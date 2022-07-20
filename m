Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16906C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jul 2022 11:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240607AbiGTLhf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jul 2022 07:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240598AbiGTLhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:37:32 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040B970E44;
        Wed, 20 Jul 2022 04:37:31 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id tk8so21182515ejc.7;
        Wed, 20 Jul 2022 04:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=VhNKxd7eGerf4c+5t3pYtmGhfXzHJ5nwhennYjjpUDo=;
        b=LREApv6SCTimmIoeyyMIxSuDuqCkBoLOrfJdoFlApsadYrIudK6ZoRs+WCQFKVY3I7
         NhOuzfNfV1jtmtkHrkekaW7XfAlc9uWqj0PQXVZ1JN9IaZl9x8Av0jxuKYl4SuRmbd8q
         3D0Xhf+DXNVvbn1nY6beJwZXR2eziOOFGaTXrfdqGPm2KwmkYzPrZlMTZUk/TY6wh+Qj
         sED39mKCy/c/OvTT0ulSqSfuEtY1ar3+eJVymSVR2B9SOu/NRRn6ObHE196LWdmiQVx8
         XhJ899Mp6+MB1Izkmg8t4XWTxbSl/HAUEMKV22xuIocdLDA3ggshhGl6HoFgYqEvNIGB
         Qftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VhNKxd7eGerf4c+5t3pYtmGhfXzHJ5nwhennYjjpUDo=;
        b=BLDv7Q0OMLVQVa9W6ItBSTYQZkmqP1Qzlt3ZYbBcVQfbp2kWtcZ3cZjDZQ5dCzkUmT
         5ge3OHIIFzlc66oCAh6qD78y7oxD5w62bPk/pl6FuJTok0dTFmZ8rj+Hl34Ybeyz/Gax
         STB9Y08S0WPNygjtY77vWN/ZKfkYtfwJTezqr0mlcLmF/UuhK06ij3aCCYw/wB1/FjgH
         Phae8Qh2+MdZooNYuoeKGHRSPfVd72RFcUBh67uxKrpB6SguQJngb14ivE1mL2CU0Zcg
         lMpBw8eTHrOdH2uCKSg/I1lUhYAuE6XlGEoBHISHHnVHcWrYQx0CwnbD5mnLxXvM98t/
         7VJg==
X-Gm-Message-State: AJIora+ugyA3pge42gWbfcUp4W7cyfHdrkjqxnJRGqxWfb0IaIiXaIK3
        jUdUNNdh8tJq5H/iUx7Q1Wg=
X-Google-Smtp-Source: AGRyM1v56IMpALyBNMP7qyZnzAwBX1pyALHup1vbAOqh5W/Au42jnRRbwBUS9wBN8vmJ7honTsvuJA==
X-Received: by 2002:a17:907:72ce:b0:72f:7b3:b9c8 with SMTP id du14-20020a17090772ce00b0072f07b3b9c8mr22102249ejc.248.1658317049475;
        Wed, 20 Jul 2022 04:37:29 -0700 (PDT)
Received: from felia.fritz.box (200116b826a11f008020c2fc6e115b3e.dip.versatel-1u1.de. [2001:16b8:26a1:1f00:8020:c2fc:6e11:5b3e])
        by smtp.gmail.com with ESMTPSA id r17-20020aa7d591000000b0043b9d4f7678sm2523731edq.96.2022.07.20.04.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 04:37:29 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] nvmet-auth: select the intended CRYPTO_DH_RFC7919_GROUPS
Date:   Wed, 20 Jul 2022 13:37:17 +0200
Message-Id: <20220720113717.31854-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 71ebe3842ebe ("nvmet-auth: Diffie-Hellman key exchange support")
intends to select 'Support for RFC 7919 FFDHE group parameters' for using
FFDHE groups for NVMe In-Band Authentication.

It however selects CRYPTO_DH_GROUPS_RFC7919, instead of the intended
CRYPTO_DH_RFC7919_GROUPS; notice the swapping of words here.

Correct the select to the intended config option.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/nvme/target/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index f0c91f7686a3..79fc64035ee3 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -93,7 +93,7 @@ config NVME_TARGET_AUTH
 	select CRYPTO_SHA256
 	select CRYPTO_SHA512
 	select CRYPTO_DH
-	select CRYPTO_DH_GROUPS_RFC7919
+	select CRYPTO_DH_RFC7919_GROUPS
 	help
 	  This enables support for NVMe over Fabrics In-band Authentication
 
-- 
2.17.1

