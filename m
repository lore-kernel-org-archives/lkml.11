Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0022C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Mar 2022 02:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353327AbiCPCsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 22:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353301AbiCPCsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 22:48:35 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFFA5BE7D;
        Tue, 15 Mar 2022 19:47:22 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id s8so1924336pfk.12;
        Tue, 15 Mar 2022 19:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8xRA0AZWP7c8dWGffE1jweFzNFfFCOIXXf8Ks3sbMCA=;
        b=M9qbaopNoIq87ycWXV7vLIYIhSiby/nAxzR4uzfusQfkYYi0u8k6mJArUwJzVj7mW/
         9gCfgLYgGboCkErAKQXyf5xN7c5++w4za9HWuvY9pJ1D02uiPtqNLcHpmd9O4+8jFe22
         MUIlkXal4Duyb9KQORpRPqau5fCR3NA4nywqZIrg6fI7ZDHjaYIBRQ0MoJociGmdGx4G
         5FnSHy7GA7qXVGTkhDY3SlR7O1ucdYPse6vqo9SZszwIB+aX2jF9IrNlp3G62EWFzSPQ
         fXepj/ud1i/oY02BcmNXAn/dUXdIJp48092xk/J6UgIeQvOJiTGit2wbXoOxVYeHl8ZM
         0b8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8xRA0AZWP7c8dWGffE1jweFzNFfFCOIXXf8Ks3sbMCA=;
        b=5XHzIvJeagGAFeZv+PO4pXgd+U4jrhpMi1vjhJQ8AcRetEWYxVLuWmvILwXcXfeFvG
         1DZV6WDyL83ciMreXbxSrlJovShYCiCvsWrIWVIGk2JtSFOqeNaP87dtr0lDxCcNstSc
         mmQt4ioeWxS1UOrlYErzjbAyQg6bUrzOHuGY2YfSmFFAurc7W+0Nri9mNMHtMr0bSaIN
         UQkzHiH8drgUjaK63GvSRZUjzykO8uo919LtYR19x3sWnqCdUPa8EgFfQs5mKOz4LbDP
         6asB6YWTZJMrAEH67qQzVYGmX4iajsehCcg3IadmJ+HOnDYFWt9TozWkSvlupdmvc7ix
         Qdvg==
X-Gm-Message-State: AOAM530h4CwvmlW+yl0JdlmxB/H8ky1qaxGF5fvNihdrHbktH/xGkQlm
        Qvqt3m/0doU9ClVMX3Gj5l4=
X-Google-Smtp-Source: ABdhPJzI8tqalxlp+CyXar4hTA26CgQBKxmYaxvhIMLz5QABcvZRXQrfkX0R+1KLItqGLMjrIdgnIA==
X-Received: by 2002:a05:6a00:1991:b0:4f7:1322:ca04 with SMTP id d17-20020a056a00199100b004f71322ca04mr31605550pfl.85.1647398842000;
        Tue, 15 Mar 2022 19:47:22 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.114])
        by smtp.gmail.com with ESMTPSA id s3-20020a056a00194300b004f6664d26eesm514630pfk.88.2022.03.15.19.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 19:47:21 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc:     rostedt@goodmis.org, mingo@redhat.com, xeb@mail.ru,
        davem@davemloft.net, yoshfuji@linux-ipv6.org,
        imagedong@tencent.com, edumazet@google.com, kafai@fb.com,
        talalahmad@google.com, keescook@chromium.org, alobakin@pm.me,
        flyingpeng@tencent.com, mengensun@tencent.com,
        dongli.zhang@oracle.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, benbjiang@tencent.com
Subject: [PATCH net-next v2 2/3] net: icmp: introduce __ping_queue_rcv_skb() to report drop reasons
Date:   Wed, 16 Mar 2022 10:46:05 +0800
Message-Id: <20220316024606.689731-3-imagedong@tencent.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220316024606.689731-1-imagedong@tencent.com>
References: <20220316024606.689731-1-imagedong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Menglong Dong <imagedong@tencent.com>

In order to avoid to change the return value of ping_queue_rcv_skb(),
introduce the function __ping_queue_rcv_skb(), which is able to report
the reasons of skb drop as its return value, as Paolo suggested.

Meanwhile, make ping_queue_rcv_skb() a simple call to
__ping_queue_rcv_skb().

The kfree_skb() and sock_queue_rcv_skb() used in ping_queue_rcv_skb()
are replaced with kfree_skb_reason() and sock_queue_rcv_skb_reason()
now.

Reviewed-by: Hao Peng <flyingpeng@tencent.com>
Reviewed-by: Biao Jiang <benbjiang@tencent.com>
Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
v2:
- introduce __ping_queue_rcv_skb() instead of change the return value
  of ping_queue_rcv_skb()
---
 net/ipv4/ping.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 3ee947557b88..138eeed7727b 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -934,16 +934,24 @@ int ping_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int noblock,
 }
 EXPORT_SYMBOL_GPL(ping_recvmsg);
 
-int ping_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
+static enum skb_drop_reason __ping_queue_rcv_skb(struct sock *sk,
+					  struct sk_buff *skb)
 {
+	enum skb_drop_reason reason;
+
 	pr_debug("ping_queue_rcv_skb(sk=%p,sk->num=%d,skb=%p)\n",
 		 inet_sk(sk), inet_sk(sk)->inet_num, skb);
-	if (sock_queue_rcv_skb(sk, skb) < 0) {
-		kfree_skb(skb);
+	if (sock_queue_rcv_skb_reason(sk, skb, &reason) < 0) {
+		kfree_skb_reason(skb, reason);
 		pr_debug("ping_queue_rcv_skb -> failed\n");
-		return -1;
+		return reason;
 	}
-	return 0;
+	return SKB_NOT_DROPPED_YET;
+}
+
+int ping_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
+{
+	return __ping_queue_rcv_skb(sk, skb) ?: -1;
 }
 EXPORT_SYMBOL_GPL(ping_queue_rcv_skb);
 
-- 
2.35.1

