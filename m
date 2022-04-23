Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C74C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Apr 2022 13:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbiDWNSJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Apr 2022 09:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbiDWNRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 09:17:44 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A284E1DD225
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 06:14:47 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id j17so10535437pfi.9
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 06:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nathanrossi.com; s=google;
        h=date:message-id:in-reply-to:references:from:to:cc:subject
         :content-transfer-encoding:mime-version;
        bh=4YclSW6gUKf5MgMzUrKvKMBlGt79OLyjo7N4NZYQLB4=;
        b=WiAmBJNtVS5Qme3dVsWfGzHmGL14wb5EWoGeGXZlWQzPxpmicnYHiK8+jczdgzrxbp
         b40OJs8mAVOMoNeZX65SDMe0cOKwV2AmNqeBqtTbTFzG5QoLkaYE00ujDsyfF3X3bQ6v
         Gqi/QkepW9fIHrdYbd+KLQfOT0jixMVs20vDIPNudoyTL4y+NClZ0PIJXeHG5TUy1Vly
         QC0QkgYkBkF9E5QFrCnKnwwaw7lN4j+5w3uqWSF5aF2BWQWy5a7L4lyd4QWum7wjBBO6
         j9p1yutM0bcGJfOYj3tidBLQF+7snY50iVlwMhXnTbxMHYW2ha/Qu/QoSMeJ3VPw4Czj
         UmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from:to
         :cc:subject:content-transfer-encoding:mime-version;
        bh=4YclSW6gUKf5MgMzUrKvKMBlGt79OLyjo7N4NZYQLB4=;
        b=DqyijuyjipwbBv8Li8JgXesbKNxml5SH/MPYFGVtDaAtWn55Vkbwk9sV7mUfMzEsMh
         Z8DFOHC23xhO+9/e6PkX0+9nD2JRb9VzWAO5FBr3ZMT6/46l0QVhO1JLgdXMA8ENOBnQ
         lI1bV6Tdk7otr04BVb2Ljx9HQYpF1dZG79LAEr3Q2yNL+NYYNhWr/LWiDOfpavLm4J1q
         LposbzMUqBrwzCsZBuQEIPPVCi8zdd//OwEqxZECKkIc4A6E23L3olL51qc1ykXwobqW
         bEnuz4QHyA3U/aQqXN1JSYkjbuoNR9jIdczTsiVNcEMi6AEOtCXQ4vFDv5mhjdEoMh3x
         jZTg==
X-Gm-Message-State: AOAM531rkmKHRNzgJSX+K8XuJd1a3H8YnO19jmI83dK9LFy26ERTW7hM
        wttzgfcJYMSMSx6Eaaq2mOY7rA==
X-Google-Smtp-Source: ABdhPJyWb4INtP/Dw8rk2zW4A2CHp/HGtqOO06IJCI2rvVP802Z4aQjnRm4vdVlEnQPwHJEn6lU3Sg==
X-Received: by 2002:a65:4189:0:b0:3a2:1682:5fc with SMTP id a9-20020a654189000000b003a2168205fcmr7884940pgq.426.1650719687253;
        Sat, 23 Apr 2022 06:14:47 -0700 (PDT)
Received: from [127.0.1.1] (117-20-68-98.751444.bne.nbn.aussiebb.net. [117.20.68.98])
        by smtp.gmail.com with UTF8SMTPSA id j10-20020a17090a734a00b001bf31f7520csm941202pjs.1.2022.04.23.06.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 06:14:46 -0700 (PDT)
Date:   Sat, 23 Apr 2022 13:14:27 +0000
Message-Id: <20220423131427.237160-2-nathan@nathanrossi.com>
In-Reply-To: <20220423131427.237160-1-nathan@nathanrossi.com>
References: <20220423131427.237160-1-nathan@nathanrossi.com>
From:   Nathan Rossi <nathan@nathanrossi.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nathan Rossi <nathan@nathanrossi.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 2/2] net: dsa: mv88e6xxx: Handle single-chip-address OF property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle the parsing and use of single chip addressing when the switch has
the single-chip-address property defined. This allows for specifying the
switch as using single chip addressing even when mdio address 0 is used
by another device on the bus. This is a feature of some switches (e.g.
the MV88E6341/MV88E6141) where the switch shares the bus only responding
to the higher 16 addresses.

Signed-off-by: Nathan Rossi <nathan@nathanrossi.com>
---
 drivers/net/dsa/mv88e6xxx/smi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/smi.c b/drivers/net/dsa/mv88e6xxx/smi.c
index a990271b74..1eb31c1563 100644
--- a/drivers/net/dsa/mv88e6xxx/smi.c
+++ b/drivers/net/dsa/mv88e6xxx/smi.c
@@ -171,9 +171,12 @@ static const struct mv88e6xxx_bus_ops mv88e6xxx_smi_indirect_ops = {
 int mv88e6xxx_smi_init(struct mv88e6xxx_chip *chip,
 		       struct mii_bus *bus, int sw_addr)
 {
+	struct device_node *np = chip->dev->of_node;
+
 	if (chip->info->dual_chip)
 		chip->smi_ops = &mv88e6xxx_smi_dual_direct_ops;
-	else if (sw_addr == 0)
+	else if (sw_addr == 0 ||
+		 (np && of_property_read_bool(np, "single-chip-address")))
 		chip->smi_ops = &mv88e6xxx_smi_direct_ops;
 	else if (chip->info->multi_chip)
 		chip->smi_ops = &mv88e6xxx_smi_indirect_ops;
---
2.35.2
