Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6F7C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 01:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445796AbiDFBWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 21:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349476AbiDEJtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:49:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD74327CF2;
        Tue,  5 Apr 2022 02:47:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68F2BB81B14;
        Tue,  5 Apr 2022 09:47:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABF1C385A1;
        Tue,  5 Apr 2022 09:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649152019;
        bh=Lq7uEknIvP4GPj5dBJRcnfmvSL9QX0ZCmPatFqEOiX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xTXvv0848gzPJaqWM3V0Upby3jzdbu6m2kkk6jC3O0vLOxA6pqv9Qs4DU4JT9hsOi
         Ur453fUZmItSB+lNr/mKdMAKnM7sjGUraXKYcjEwm10TOQotj0a6H+TI3EYQd3axGA
         fMbfjaTbhewLBM1zW0LbtZmL0gqAVU00Vu5rZM5M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 626/913] NFS: remove unneeded check in decode_devicenotify_args()
Date:   Tue,  5 Apr 2022 09:28:08 +0200
Message-Id: <20220405070358.603196433@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070339.801210740@linuxfoundation.org>
References: <20220405070339.801210740@linuxfoundation.org>
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
index ce3d1d5b1291..ea17085ef884 100644
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



