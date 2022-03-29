Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AFDC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Mar 2022 10:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbiC2Kl4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Mar 2022 06:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiC2Klx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:41:53 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF097385;
        Tue, 29 Mar 2022 03:40:10 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id a11so14812553qtb.12;
        Tue, 29 Mar 2022 03:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s+fLpNYO75AAoy7NNFLD86hgUAL4EoVoOHLoqhAWagI=;
        b=jjavy4KLUVboSTXFMStOFALet2MVBYBBv03s2XU7VKfYedVrJ9YDSnqZicppw7nmRu
         ki1hX/HiG1EjmJHPZ8T1pQ9tpEfmht3Up98KVDhANapTGSV0hq8bi9kG8ZRa7O2SyABB
         ziAoR5Q7qxk5lBBivQ7FMyvnTvcSRfLFx4z9sAWXcbiUgafXi4CgH6zSddfrsI8MWJsF
         tsClG9SsKDvg5jgNbSDd8v0KVawqCWFlNTzWlNsZTmWqjm6qj50tdqY/fO5lHEdwTcBl
         7KKYhsZuPQdseJyKGteo9j2zRhtZJsETjas1bEJk35LxjhlZ+sG8xxzFOPxBQyB7ysGh
         tFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s+fLpNYO75AAoy7NNFLD86hgUAL4EoVoOHLoqhAWagI=;
        b=2wxN1YCF32UhZHnibM2iOS7QDpBxemkbFd9wEFvQfPpr0cpIRB7IbSb9w79Mduns3e
         srxie+EfIHskQLoB/teyHQH0zRsLNEEDde7MSP40wrV4ZORSeqk35Yg1+25MdV1i/ve3
         e4TGjAgO4EH/SmTWxratAo3+4DOScXc4095q3li1J3+00Cvubnbwl4DSxdlkRNAvu62E
         Cn1pFl5GapKvm/raiO6jm/U8OUCxXvnKzWmHIqYFMz4lU6sFiRgHKikma14UwVQAOYLL
         QJegErtTbNgkWC6be8pf/4FgLMRxHHqnpFeI+qqwJrjMRgY1gEQmHbzSDZc/Jc5/BJY0
         VEHA==
X-Gm-Message-State: AOAM531/VrQ16pUiFeoVMI1g9e00jhtdZQAA0Mq8iCBOFMC+LrZoCdw7
        FJSMaajBK5pcZMzDmRQM0Bk=
X-Google-Smtp-Source: ABdhPJzTGaITHPstV0dRg6D95rqg2Iq0pDT+OUsIw//+lmiNMElrqv1C91w8HoKNrVuf9o2+UeLAPA==
X-Received: by 2002:ac8:66cc:0:b0:2e2:160d:7e06 with SMTP id m12-20020ac866cc000000b002e2160d7e06mr26821295qtp.673.1648550409897;
        Tue, 29 Mar 2022 03:40:09 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id bm21-20020a05620a199500b0067d5e6c7bd8sm9420563qkb.56.2022.03.29.03.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 03:40:09 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] proc: bootconfig: add null pointer check
Date:   Tue, 29 Mar 2022 10:40:04 +0000
Message-Id: <20220329104004.2376879-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lv Ruyi <lv.ruyi@zte.com.cn>

kzalloc is a memory allocation function which can return NULL when some
internal memory errors happen. It is safer to add null pointer check.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 fs/proc/bootconfig.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/proc/bootconfig.c b/fs/proc/bootconfig.c
index 6d8d4bf20837..2e244ada1f97 100644
--- a/fs/proc/bootconfig.c
+++ b/fs/proc/bootconfig.c
@@ -32,6 +32,8 @@ static int __init copy_xbc_key_value_list(char *dst, size_t size)
 	int ret = 0;
 
 	key = kzalloc(XBC_KEYLEN_MAX, GFP_KERNEL);
+	if (!key)
+		return -ENOMEM;
 
 	xbc_for_each_key_value(leaf, val) {
 		ret = xbc_node_compose_key(leaf, key, XBC_KEYLEN_MAX);
-- 
2.25.1

