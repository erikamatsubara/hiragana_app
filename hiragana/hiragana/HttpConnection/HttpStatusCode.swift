//
//  HttpStatusCode.swift
//  hiragana
//
//  Created by 松原えりか on 2019/08/08.
//  Copyright © https://qiita.com/t_nagano/items/5c30c83270956f48a3aa
//

enum HttpStatusCode: Int {
    
    /*!
     @brief 継続 クライアントはリクエストを継続できる。
     */
    case Continue = 100
    
    /*!
     @brief プロトコル切り替え サーバはリクエストを理解し、遂行のためにプロトコルの切り替えを要求している
     */
    case switchingProtocols = 101
    
    /*!
     @brief 処理中 WebDAVの拡張ステータスコード。処理が継続して行われていることを示す。
     */
    case processing = 102
    
    /*!
     @brief OK リクエストは成功し、レスポンスとともに要求に応じた情報が返される。
     */
    case ok = 200
    
    /*!
     @brief 作成 リクエストは完了し、新たに作成されたリソースのURIが返される。
     */
    case created = 201
    
    /*!
     @brief 受理 リクエストは受理されたが、処理は完了していない。
     */
    case accepted = 202
    
    /*!
     @brief 信頼できない情報 オリジナルのデータではなく、ローカルやプロキシ等からの情報であることを示す。
     */
    case nonAuthoritativeInformation = 203
    
    /*!
     @brief 内容なし リクエストを受理したが、返すべきレスポンスエンティティが存在しない場合に返される。
     */
    case noContent = 204
    
    /*!
     @brief 内容のリセット リクエストを受理し、ユーザエージェントの画面をリセットする場合に返される。
     */
    case resetContent = 205
    
    /*!
     @brief 部分的内容 部分的GETリクエストを受理したときに、返される。
     */
    case partialContent = 206
    
    /*!
     @brief 複数のステータス WebDAVの拡張ステータスコード。
     */
    case multiStatus = 207
    
    /*!
     @brief IM使用 Delta encoding in HTTPの拡張ステータスコード。
     */
    case IMUsed = 226
    
    /*!
     @brief 複数の選択 リクエストしたリソースが複数存在し、ユーザやユーザーエージェントに選択肢を提示するときに返される。
     */
    case multipleChoices = 300
    
    /*!
     @brief 恒久的に移動した リクエストしたリソースが恒久的に移動されているときに返される。Location:ヘッダに移動先のURLが示されている。
     */
    case movedPermanently = 301
    
    /*!
     @brief 発見した リクエストしたリソースが一時的に移動されているときに返される。Location:ヘッダに移動先のURLが示されている。
     */
    case found = 302
    
    /*!
     @brief 他を参照せよ リクエストに対するレスポンスが他のURLに存在するときに返される。Location:ヘッダに移動先のURLが示されている。
     */
    case seeOther = 303
    
    /*!
     @brief 未更新 リクエストしたリソースは更新されていないことを示す。
     */
    case notModified = 304
    
    /*!
     @brief プロキシを使用せよ レスポンスのLocation:ヘッダに示されるプロキシを使用してリクエストを行わなければならないことを示す。
     */
    case useProxy = 305
    
    /*!
     @brief 将来のために予約されている。ステータスコードは前のバージョンの仕様書では使われていたが、もはや使われておらず、将来のために予約されているとされる。
     */
    case unUsed = 306
    
    /*!
     @brief 一時的リダイレクト リクエストしたリソースは一時的に移動されているときに返される。Location:ヘッダに移動先のURLが示されている。
     */
    case temporaryRedirect = 307
    
    /*!
     @brief リクエストが不正である 定義されていないメソッドを使うなど、クライアントのリクエストがおかしい場合に返される。
     */
    case badRequest = 400
    
    /*!
     @brief 認証が必要である Basic認証やDigest認証などを行うときに使用される。
     */
    case unauthorized = 401
    
    /*!
     @brief 支払いが必要である 現在は実装されておらず、将来のために予約されているとされる。
     */
    case paymentRequired = 402
    
    /*!
     @brief 禁止されている リソースにアクセスすることを拒否された。
     */
    case forbidden = 403
    
    /*!
     @brief 未検出 リソースが見つからなかった。
     */
    case notFound = 404
    
    /*!
     @brief 許可されていないメソッド 許可されていないメソッドを使用しようとした。
     */
    case methodNotAllowed = 405
    
    /*!
     @brief 受理できない Accept関連のヘッダに受理できない内容が含まれている場合に返される。
     */
    case notAcceptable = 406
    
    /*!
     @brief プロキシ認証が必要である プロキシの認証が必要な場合に返される。
     */
    case proxyAuthenticationRequired = 407
    
    /*!
     @brief リクエストタイムアウト リクエストが時間以内に完了していない場合に返される。
     */
    case requestTimeout = 408
    
    /*!
     @brief 矛盾 要求は現在のリソースと矛盾するので完了できない。
     */
    case conflict = 409
    
    /*!
     @brief 消滅した。ファイルは恒久的に移動した。
     */
    case gone = 410
    
    /*!
     @brief 長さが必要 Content-Lengthヘッダがないのでサーバーがアクセスを拒否した場合に返される。
     */
    case lengthRequired = 411
    
    /*!
     @brief 前提条件で失敗した 前提条件が偽だった場合に返される。
     */
    case preconditionFailed = 412
    
    /*!
     @brief リクエストエンティティが大きすぎる リクエストエンティティがサーバの許容範囲を超えている場合に返す。
     */
    case requestEntityTooLarge = 413
    
    /*!
     @brief リクエストURIが大きすぎる URIが長過ぎるのでサーバが処理を拒否した場合に返す。
     */
    case requestURITooLong = 414
    
    /*!
     @brief サポートしていないメディアタイプ 指定されたメディアタイプがサーバでサポートされていない場合に返す。
     */
    case unsupportedMediaType = 415
    
    /*!
     @brief リクエストしたレンジは範囲外にある 実ファイルのサイズを超えるデータを要求した。
     */
    case requestedRangeNotSatisfiable = 416
    
    /*!
     @brief Expectヘッダによる拡張が失敗 その拡張はレスポンスできない。またはプロキシサーバは、次に到達するサーバがレスポンスできないと判断している。
     */
    case expectationFailed = 417
    
    /*!
     @brief 私はティーポット HTCPCP/1.0の拡張ステータスコード。
     */
    case imaTeapot = 418
    
    /*!
     @brief 処理できないエンティティ WebDAVの拡張ステータスコード。
     */
    case unprocessableEntity = 422
    
    /*!
     @brief ロックされている WebDAVの拡張ステータスコード。リクエストしたリソースがロックされている場合に返す。
     */
    case locked = 423
    
    /*!
     @brief 依存関係で失敗 WebDAVの拡張ステータスコード。
     */
    case failedDependency = 424
    
    /*!
     @brief アップグレード要求 Upgrading to TLS Within HTTP/1.1の拡張ステータスコード。
     */
    case upgradeRequired = 426
    
    /*!
     @brief サーバ内部エラー サーバ内部にエラーが発生した場合に返される。
     */
    case internalServerError = 500
    
    /*!
     @brief 実装されていない 実装されていないメソッドを使用した。
     */
    case notImplemented = 501
    
    /*!
     @brief 不正なゲートウェイ ゲートウェイ・プロキシサーバは不正な要求を受け取り、これを拒否した。
     */
    case badGateway = 502
    
    /*!
     @brief サービス利用不可 サービスが一時的に過負荷やメンテナンスで使用不可能である。
     */
    case serviceUnavailable = 503
    
    /*!
     @brief ゲートウェイタイムアウト ゲートウェイ・プロキシサーバはURIから推測されるサーバからの適切なレスポンスがなくタイムアウトした。
     */
    case gatewayTimeout = 504
    
    /*!
     @brief サポートしていないHTTPバージョン リクエストがサポートされていないHTTPバージョンである場合に返される。
     */
    case httpVersionNotSupported = 505
    
    /*!
     @brief Transparent Content Negotiation in HTTPで定義されている拡張ステータスコード。
     */
    case variantAlsoNegotiates = 506
    
    /*!
     @brief 容量不足 WebDAVの拡張ステータスコード。リクエストを処理するために必要なストレージの容量が足りない場合に返される。
     */
    case insufficientStorage = 507
    
    /*!
     @brief 帯域幅制限超過 そのサーバに設定されている帯域幅（転送量）を使い切った場合に返される。
     */
    case bandwidthLimitExceeded = 509
    
    /*!
     @brief 拡張できない An HTTP Extension Frameworkで定義されている拡張ステータスコード。
     */
    case notExtended = 510
}

