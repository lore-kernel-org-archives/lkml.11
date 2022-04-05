Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D7EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 12:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357472AbiDELz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 07:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244960AbiDEIwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:52:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86121C12B;
        Tue,  5 Apr 2022 01:47:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5406361504;
        Tue,  5 Apr 2022 08:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62364C385A0;
        Tue,  5 Apr 2022 08:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649148476;
        bh=sRY6U65i0znfe3KehcP3ZybCJpLi0ibCWb/vy8ikJbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nrknhYeZLJUk6Wo6kgfnbjXsgsQGiY1oDGUJowHtcd5XFCAmWehzkpbXqmr5vMsGI
         PtaQEBFF24A1aZnvOUqqar5md8qmwIwfY05cYbiOA5urMv1QnEO1NKG5IgVtA374o1
         T/ztW3QyrShJKa5SGEinzskkAYdo7obFY2ZnQYtA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 0369/1017] media: vidtv: Check for null return of vzalloc
Date:   Tue,  5 Apr 2022 09:21:22 +0200
Message-Id: <20220405070405.238860696@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070354.155796697@linuxfoundation.org>
References: <20220405070354.155796697@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiasheng Jiang <jiasheng@iscas.ac.cn>

[ Upstream commit e6a21a14106d9718aa4f8e115b1e474888eeba44 ]

As the possible failure of the vzalloc(), e->encoder_buf might be NULL.
Therefore, it should be better to check it in order
to guarantee the success of the initialization.
If fails, we need to free not only 'e' but also 'e->name'.
Also, if the allocation for ctx fails, we need to free 'e->encoder_buf'
else.

Fixes: f90cf6079bf6 ("media: vidtv: add a bridge driver")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/test-drivers/vidtv/vidtv_s302m.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/media/test-drivers/vidtv/vidtv_s302m.c b/drivers/media/test-drivers/vidtv/vidtv_s302m.c
index d79b65854627..4676083cee3b 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_s302m.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_s302m.c
@@ -455,6 +455,9 @@ struct vidtv_encoder
 		e->name = kstrdup(args.name, GFP_KERNEL);
 
 	e->encoder_buf = vzalloc(VIDTV_S302M_BUF_SZ);
+	if (!e->encoder_buf)
+		goto out_kfree_e;
+
 	e->encoder_buf_sz = VIDTV_S302M_BUF_SZ;
 	e->encoder_buf_offset = 0;
 
@@ -467,10 +470,8 @@ struct vidtv_encoder
 	e->is_video_encoder = false;
 
 	ctx = kzalloc(priv_sz, GFP_KERNEL);
-	if (!ctx) {
-		kfree(e);
-		return NULL;
-	}
+	if (!ctx)
+		goto out_kfree_buf;
 
 	e->ctx = ctx;
 	ctx->last_duration = 0;
@@ -498,6 +499,14 @@ struct vidtv_encoder
 	e->next = NULL;
 
 	return e;
+
+out_kfree_buf:
+	kfree(e->encoder_buf);
+
+out_kfree_e:
+	kfree(e->name);
+	kfree(e);
+	return NULL;
 }
 
 void vidtv_s302m_encoder_destroy(struct vidtv_encoder *e)
-- 
2.34.1



