Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B16DC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jun 2022 09:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbiFLJBG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jun 2022 05:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbiFLJA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 05:00:59 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53D951E4F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 02:00:52 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so1602714wms.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 02:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ELhqEDOqgmC+TbLCt4NyDbvbHR56jry/w5HtXxvrUIM=;
        b=PaZYXKu8oFHY0LGzLxFo66YYimisvTv48Bj8XCIKfLpjdtwA5eikvThJJwxRW5WgYG
         m6/1fv09uv8Q9xhYBCq4o2+KLW3MutYdmX/1ljpZoq+2GlpOkiLdQGZWqnuj8+qoVTvB
         T45fXPVb9A6z8tzB5O+p0Sm1B0o5nToqWufhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ELhqEDOqgmC+TbLCt4NyDbvbHR56jry/w5HtXxvrUIM=;
        b=PqdJl+34xZa4j8qhab3ps/7MJZM2V0VYSaLKrgGvW4E0bz/dKPo1e6fSIcW3LXf+kI
         5Vqmj38KhAePXtjV4c69xYf2B7VYhoVc5wAT+9tjtSAIhO2AK01dxOVU/MmbYwaNwyJ2
         w46MAjZcPtgLB6l5FNwH7tZyJSvw+yVkio18caH7enRJlwwZYYvTzbwNcQiD/ZEKdFJw
         HOOznIJMvB2IGAp7qy85vx1XokuVSitbLG2KGgWhpb60fxJVpMy/rW+Jg1NUbLyx3V2a
         iA5E2Oc9HPx34zdQggk6Se/EeHPIsqRz2gGBp7AFB8gMN1al71BkIUORPqydwtUDOcQC
         uNuQ==
X-Gm-Message-State: AOAM532jimV11xLGim3v6Xkd9VM2afiawN7fBsrCKGSGG9iyLd058UBl
        Afm2jrs5OXIWOz48z0ZY0PBGZQ==
X-Google-Smtp-Source: ABdhPJzd9bkHYJC56LA9yvbOs3N/OrPbAmtYouTWcxhGPvju+dr0MxD3WT7YPW2C1hZk3nHzKsVgMA==
X-Received: by 2002:a05:600c:4a28:b0:39c:4d97:37e2 with SMTP id c40-20020a05600c4a2800b0039c4d9737e2mr8439018wmp.31.1655024451149;
        Sun, 12 Jun 2022 02:00:51 -0700 (PDT)
Received: from localhost.localdomain ([178.130.153.185])
        by smtp.gmail.com with ESMTPSA id d34-20020a05600c4c2200b0039c5b4ab1b0sm4798603wmp.48.2022.06.12.02.00.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2022 02:00:49 -0700 (PDT)
From:   Joe Damato <jdamato@fastly.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Joe Damato <jdamato@fastly.com>
Subject: [RFC,net-next v2 7/8] net: udplite: Support MSG_NTCOPY
Date:   Sun, 12 Jun 2022 01:57:56 -0700
Message-Id: <1655024280-23827-8-git-send-email-jdamato@fastly.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655024280-23827-1-git-send-email-jdamato@fastly.com>
References: <1655024280-23827-1-git-send-email-jdamato@fastly.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support non-temporal copies of udp-lite data when applications set the
MSG_NTCOPY.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 include/net/udplite.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/udplite.h b/include/net/udplite.h
index a3c5311..000677c5 100644
--- a/include/net/udplite.h
+++ b/include/net/udplite.h
@@ -21,6 +21,7 @@ static __inline__ int udplite_getfrag(void *from, char *to, int  offset,
 				      int len, int odd, struct sk_buff *skb)
 {
 	struct msghdr *msg = from;
+	msg_set_iter_copy_type(msg);
 	return copy_from_iter_full(to, len, &msg->msg_iter) ? 0 : -EFAULT;
 }
 
-- 
2.7.4

