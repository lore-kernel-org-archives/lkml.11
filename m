Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A477CC4321E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 09:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343493AbiDEJMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 05:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239536AbiDEIUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:20:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8F81087;
        Tue,  5 Apr 2022 01:15:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE9AE609D0;
        Tue,  5 Apr 2022 08:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F339C385A0;
        Tue,  5 Apr 2022 08:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649146539;
        bh=ozgDpeQbRz+nwF7LtcGxvCmInBpHwmGYhYa0sZuN1KA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xHy+RdmY1Z8i1OZCdqIhMDL/wRbzqZul23g55cFPJTjBSruyM7Us22JvmaPi/DwA3
         RzTDNlpZIee2e6b2fWSz4Zi3xKjrLbfDexTLnCl7ooO4PGPmcZtwZEXbBkArDm1dw9
         puMBjVehDS09m3/BXM8LeBlGvVKXFADM85UM0SQI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 0762/1126] NFS: remove unneeded check in decode_devicenotify_args()
Date:   Tue,  5 Apr 2022 09:25:09 +0200
Message-Id: <20220405070429.949588497@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070407.513532867@linuxfoundation.org>
References: <20220405070407.513532867@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Khoroshilov <khoroshilov@ispras.ru>

[ Upstream commit cb8fac6d2727f79f211e745b16c9abbf4d8be652 ]

[You don't often get email from khoroshilov@ispras.ru. Learn why this is important at http://aka.ms/LearnAboutSenderIdentification.]

Overflow check in not needed anymore after we switch to kmalloc_array().

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Fixes: a4f743a6bb20 ("NFSv4.1: Convert open-coded array allocation calls to kmalloc_array()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/callback_xdr.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index f90de8043b0f..8dcb08e1a885 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -271,10 +271,6 @@ __be32 decode_devicenotify_args(struct svc_rqst *rqstp,
 	n = ntohl(*p++);
 	if (n == 0)
 		goto out;
-	if (n > ULONG_MAX / sizeof(*args->devs)) {
-		status = htonl(NFS4ERR_BADXDR);
-		goto out;
-	}
 
 	args->devs = kmalloc_array(n, sizeof(*args->devs), GFP_KERNEL);
 	if (!args->devs) {
-- 
2.34.1



