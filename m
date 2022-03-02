Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D737BC433FE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 19:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240578AbiCBT0n (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 14:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240280AbiCBT0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:26:32 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FBCC12F3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:25:36 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D81B73F60F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646249134;
        bh=k1fbxXsPvGzkuFTuMvPObzXkHdaiukX+p5UqHJ6OWe0=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=O2U9gGpVeNUt6D/I0+4d4RaNrfBv0pA8LaErnPR9Dctk6D0zaTr9UFM0+CumJIJ9k
         ayKkS+22U7QlwbtytlSwumNgVABo5y7hfV/X5zWhMhERAGSCDecjEaCfsuPhPUd1OD
         bs/bkr0adPa78Zyi/uJpsos3a7EnIJ/AYqJNVDAeynEQAguzkLKUFMHNkumMmZnvwl
         PJzS7EjwAiw9U55/8+rVpQwnbCIhbLehWxcu7LcB4jYcF6Ss8/1hS2hNP0b10hsuBC
         uFrVuAEwbYZ34Hr+sUgkx098Hd2XqQj32Gov4JLeZDkxsqOlHS1iImo3A2qBCj3IiS
         9pPBFRVBGBm2A==
Received: by mail-ej1-f69.google.com with SMTP id k21-20020a1709063e1500b006d0777c06d6so1502863eji.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 11:25:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k1fbxXsPvGzkuFTuMvPObzXkHdaiukX+p5UqHJ6OWe0=;
        b=DbJfaIBynPFxVeJwwVpeG9hqxhcz1tu3yfNyiSusTnKMXo56cqf17/TRBy7lBe6XPy
         q/3FY0wHQahkLXBWUit+JQsEvbW47DTQnnQqEeeCv+bG+fRzEznhglohHyKLc/G/6Fo9
         1TiJlaB64/TcFaPFRCHqi3KyMspBWBc+UcS/wMIjQxaKAt2l2Ol+VPwLSaLqVqzu7JJJ
         /DWhL/9LjkR/r+/xqaXcvsqeJw6QkAx6vc31RotSM15YfX5dN8i+ZZr8L8Q+xv4/U+sI
         BCvMq9u1nvmy50a6k9oaq+hgYutl8V1mCyX+afH02Qqbk36A0P9YQJmDiyxNXEBC6vO8
         GcLw==
X-Gm-Message-State: AOAM531W9hHZVhDPAPfb9rgVbH0/H6DiE45HkUNunuyM7KATjG/LOoBM
        tz8BCI4E1oQIg3/5yQpvAaswV0RUNdvb/RiW5qZloo0ImGCrcmn56mCKu8TyYxp7EuL2BEn8cDe
        jTwmzu+CMEkkzn2GC5dH05Nra/5YECge4XB9mNW84wA==
X-Received: by 2002:a17:906:18b2:b0:6d0:ee54:1add with SMTP id c18-20020a17090618b200b006d0ee541addmr24364520ejf.499.1646249134540;
        Wed, 02 Mar 2022 11:25:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQ2Yzk4nLxgx+97QWgQ7U+3qiE+VAfZ5ZxF3hEUaZA9fAEq5MaAHHtVajBlFnerH2vg2MVHw==
X-Received: by 2002:a17:906:18b2:b0:6d0:ee54:1add with SMTP id c18-20020a17090618b200b006d0ee541addmr24364498ejf.499.1646249134294;
        Wed, 02 Mar 2022 11:25:34 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id i14-20020a50cfce000000b00415b0730921sm1482765edk.42.2022.03.02.11.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 11:25:33 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 5/6] nfc: llcp: protect nfc_llcp_sock_unlink() calls
Date:   Wed,  2 Mar 2022 20:25:22 +0100
Message-Id: <20220302192523.57444-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220302192523.57444-1-krzysztof.kozlowski@canonical.com>
References: <20220302192523.57444-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nfc_llcp_sock_link() is called in all paths (bind/connect) as a last
action, still protected with lock_sock().  When cleaning up in
llcp_sock_release(), call nfc_llcp_sock_unlink() in a mirrored way:
earlier and still under the lock_sock().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 net/nfc/llcp_sock.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index c9d5c427f035..5c5705f5028b 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -631,6 +631,11 @@ static int llcp_sock_release(struct socket *sock)
 		}
 	}
 
+	if (sock->type == SOCK_RAW)
+		nfc_llcp_sock_unlink(&local->raw_sockets, sk);
+	else
+		nfc_llcp_sock_unlink(&local->sockets, sk);
+
 	if (llcp_sock->reserved_ssap < LLCP_SAP_MAX)
 		nfc_llcp_put_ssap(llcp_sock->local, llcp_sock->ssap);
 
@@ -643,11 +648,6 @@ static int llcp_sock_release(struct socket *sock)
 	if (sk->sk_state == LLCP_DISCONNECTING)
 		return err;
 
-	if (sock->type == SOCK_RAW)
-		nfc_llcp_sock_unlink(&local->raw_sockets, sk);
-	else
-		nfc_llcp_sock_unlink(&local->sockets, sk);
-
 out:
 	sock_orphan(sk);
 	sock_put(sk);
-- 
2.32.0

