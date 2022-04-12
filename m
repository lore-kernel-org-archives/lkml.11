Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0F7C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 08:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380156AbiDLIV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 04:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353933AbiDLHZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:25:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9C91263E;
        Tue, 12 Apr 2022 00:05:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9AA78B81A8F;
        Tue, 12 Apr 2022 07:05:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BB9C385A6;
        Tue, 12 Apr 2022 07:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649747111;
        bh=4kHxTx+nZTZet0xhrBn9ebOlglwAHA+XhrKvmS0m9VA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xUovsqyXJP3uyjWzgBdDLYVbZP2asZRpih4yMIIHavrNsb+IJUg6ukbJCMGT0tl9b
         p0mbKGYNI8s3AxQnB/bEaMZAPnw4CYrbjr8Idbce6/YRjUl8upJQ6Uapkgfn7mXlA3
         mD94iwoAz2xNp5zrRYrx91OyaKieqX2ERrfBGxr0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 207/285] SUNRPC: svc_tcp_sendmsg() should handle errors from xdr_alloc_bvec()
Date:   Tue, 12 Apr 2022 08:31:04 +0200
Message-Id: <20220412062949.633716901@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412062943.670770901@linuxfoundation.org>
References: <20220412062943.670770901@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit b056fa070814897be32d83b079dbc311375588e7 ]

The allocation is done with GFP_KERNEL, but it could still fail in a low
memory situation.

Fixes: 4a85a6a3320b ("SUNRPC: Handle TCP socket sends with kernel_sendpage() again")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/svcsock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 478f857cdaed..6ea3d87e1147 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1096,7 +1096,9 @@ static int svc_tcp_sendmsg(struct socket *sock, struct xdr_buf *xdr,
 	int ret;
 
 	*sentp = 0;
-	xdr_alloc_bvec(xdr, GFP_KERNEL);
+	ret = xdr_alloc_bvec(xdr, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
 
 	ret = kernel_sendmsg(sock, &msg, &rm, 1, rm.iov_len);
 	if (ret < 0)
-- 
2.35.1



