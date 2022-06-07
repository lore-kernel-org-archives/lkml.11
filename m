Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99993C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 10:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241255AbiFGKko (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 06:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241301AbiFGKkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:40:21 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0545E3DD3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:40:20 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id bg7-20020a05600c3c8700b0039468585269so5630677wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 03:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vp9jkXdHUO1DqPeSha9qftW6M3HjLENX1BSG2nBOYec=;
        b=L/d7E0ruhw+z2PEX2oHfo6yWRopH97esndR0q5+CmlZeJcbqdrUV8/COiJxOtIG0mm
         uYwk+VyPn16RgA4huLOrZrZsXIOaCruMp49r6YxJBKthhqGSZVrcrXq3PbT4xtHWV6eU
         aUqXBTKpn5cHoj6AVfsSTU/PGYHPETZtbWXB/ghILI84Y8mvyJgnnCJNcA4HbhmN4DsE
         RYLEcz0t08E8DrBIIZ4JUfbmd65v7ZrH0y/k8WU3/PMgrCBj8jsCtq70X/5K4CD42JPY
         2a5dsw7c0NDzrOcLlNqWxsmUwmtOrOCrT1qaKzFBilsVDLx79rkdiI/Fvo976sYI3ojk
         oJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vp9jkXdHUO1DqPeSha9qftW6M3HjLENX1BSG2nBOYec=;
        b=HaubN9ScnPwQf4rxd2g/aFVh+gCcPyoMDOzXpsj30Su5/f7sfDhInKfyCXTZVB1Sha
         6gjMCoLqEiTt715Y6Ljtr/TQLs8iB6AvdhuvaTPRt/2AVDGZx+fbe7o8kAxljLRapoCC
         9DXUpputcgU60nwgu47s26mt3Uftw9wqphlKFRkYdu311sbwI8BFE/7eet7utV78L6hf
         WeVFz/s+VeXb9n8hi5z4ZgJQMetsT5+5lcRHmRu2q+HlqacaeixgL3jP/2XQpNI2jKlM
         zHGlZpCaGYqPU6E3qLB8/Kk+g/N2htLzZSCYWoFRSL6LvcPvs9o/3OGlp6p8MKVoHp45
         kuUQ==
X-Gm-Message-State: AOAM530CurynEYySo21917L2YdnJ2R2ofCyHBa3nfBOY1ABS1MAkImvf
        Z0fB/TP6zhkttVhRXnv55U8vP99NP08=
X-Google-Smtp-Source: ABdhPJxvgrwfIpz22Ce0KF1SX3sfY5UznmDI7jTzxHwiwBUCn7AzSj/qJzgUh+eQCswzXd/lic9iRHAa+Xc=
X-Received: from rax.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2a98])
 (user=poprdi job=sendgmr) by 2002:a7b:cd83:0:b0:39c:46d2:6ebb with SMTP id
 y3-20020a7bcd83000000b0039c46d26ebbmr17251855wmj.187.1654598419076; Tue, 07
 Jun 2022 03:40:19 -0700 (PDT)
Date:   Tue,  7 Jun 2022 10:40:15 +0000
Message-Id: <20220607104015.2126118-1-poprdi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2] Bluetooth: Collect kcov coverage from hci_rx_work
From:   Tamas Koczka <poprdi@google.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, theflow@google.com,
        nogikh@google.com, Tamas Koczka <poprdi@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Annotate hci_rx_work() with kcov_remote_start() and kcov_remote_stop()
calls, so remote KCOV coverage is collected while processing the rx_q
queue which is the main incoming Bluetooth packet queue.

Coverage is associated with the thread which created the packet skb.

The collected extra coverage helps kernel fuzzing efforts in finding
vulnerabilities.

Signed-off-by: Tamas Koczka <poprdi@google.com>
---
Changelog since v1:
 - add comment about why kcov_remote functions are called

v1: https://lore.kernel.org/all/20220517094532.2729049-1-poprdi@google.com/

 net/bluetooth/hci_core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 45c2dd2e1590..0af43844c55a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -29,6 +29,7 @@
 #include <linux/rfkill.h>
 #include <linux/debugfs.h>
 #include <linux/crypto.h>
+#include <linux/kcov.h>
 #include <linux/property.h>
 #include <linux/suspend.h>
 #include <linux/wait.h>
@@ -3780,7 +3781,14 @@ static void hci_rx_work(struct work_struct *work)
 
 	BT_DBG("%s", hdev->name);
 
-	while ((skb = skb_dequeue(&hdev->rx_q))) {
+	/* The kcov_remote functions used for collecting packet parsing
+	 * coverage information from this background thread and associate
+	 * the coverage with the syscall's thread which originally injected
+	 * the packet. This helps fuzzing the kernel.
+	 */
+	for (; (skb = skb_dequeue(&hdev->rx_q)); kcov_remote_stop()) {
+		kcov_remote_start_common(skb_get_kcov_handle(skb));
+
 		/* Send copy to monitor */
 		hci_send_to_monitor(hdev, skb);
 
-- 
2.36.1.255.ge46751e96f-goog

