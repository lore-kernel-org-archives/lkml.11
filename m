Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A0DC43334
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jul 2022 22:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiGKWXc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jul 2022 18:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiGKWXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 18:23:30 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7534F69C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:23:29 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so9668460pjl.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OYShG73HxmmhPcrzkwBl6WvX/YrHXz/HpRIE2FyrmQw=;
        b=e578CQSkzdn+PVgkNC9LlD7b7BywH5qghTF7HZpGoMK30sn0lwvy7XSxzIdjUJpdyQ
         71gC55S7v9DGplaKPU9XYU9CKKa9bmUKJNLgVnyzemqjtrg8UQVxXxNN8BGRbOBvhKgb
         iN4mLBhQWwDAHh7Di6xkasXAOrMJHcpBOXWX7XtZhhY9JG4CnHIjNHiape4wdArqeSeC
         fuexCf9XcXaw2aG85KUMmN63UPbSqqWf5qHHDJKxBZ/9MVW4tbT///faQGysEdGZwZB1
         BOlO9siFTK4Svf7/bCpVw/fvl0wrNo+jbq0srb2K1vT+Y5b6h/g1cCI79RFUkOwRHU9T
         yDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OYShG73HxmmhPcrzkwBl6WvX/YrHXz/HpRIE2FyrmQw=;
        b=Qjpy9Yq1Dqg91fSK197C87up2t3pvCjg7POOCMbwru+vBxv1UvizEyVH9NRo7YHOtf
         VystKIlGb3wUX9NDV3BptzbD1DDonImUHdzpd0qhP4YWbLsMwku1yHOyfHUHxsMbAbSY
         9mu74ev+25hppBiQfsnCCXlt/g9HX+dvs2nnKl3s4U5m7563Q8GgAXvRbH/2BVIrSXdt
         7uA4LTMUteojFyiXiC7yr7xsMHAAN00DSW+TvPPKDFU2MH6Ttf0VgbIqMItskrc5q8zh
         jMLKhpn3+rc0kJnjnFgQtBWtr+QkY45QPTtHvYmzv42yOY7X4oj/67ULw6gjaYC4GSgq
         XQdw==
X-Gm-Message-State: AJIora+9uas/7v5ap6Bn8JYjL0hIEwU+dyNlaWd36lTHeCwbPoasVxVj
        1AJzgj9IxDQTEGn1W6PMee4=
X-Google-Smtp-Source: AGRyM1vxKtINcfJanedH2J8OjSrgSS7ccwzLzg8V0d1th0yEdXm4DulCbwpPuiE48UmBNmpBoSCOpQ==
X-Received: by 2002:a17:902:7483:b0:16b:f2d8:93f4 with SMTP id h3-20020a170902748300b0016bf2d893f4mr21223512pll.172.1657578209088;
        Mon, 11 Jul 2022 15:23:29 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z6-20020a170903018600b0016be5f24aaesm5274774plg.163.2022.07.11.15.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 15:23:28 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Roger Quadros <rogerq@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Colin Ian King <colin.king@intel.com>,
        linux-kernel@vger.kernel.org (open list),
        William Zhang <william.zhang@broadcom.com>
Subject: [PATCH 0/2] mtd: rawnand: brcmnand: Glue driver Kconfig entries
Date:   Mon, 11 Jul 2022 15:23:21 -0700
Message-Id: <20220711222323.4048197-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series allows for a finer control over the BRCMNAND driver
glue driver selection such that it defaults to the various platforms
enabled in the configuration file.

Florian Fainelli (2):
  mtd: rawnand: brcmnand: Move Kconfig to driver folder
  mtd: rawnand: brcmnand: Add individual glue driver selection

 drivers/mtd/nand/raw/Kconfig           | 22 +-----------
 drivers/mtd/nand/raw/brcmnand/Kconfig  | 49 ++++++++++++++++++++++++++
 drivers/mtd/nand/raw/brcmnand/Makefile |  8 ++---
 3 files changed, 54 insertions(+), 25 deletions(-)
 create mode 100644 drivers/mtd/nand/raw/brcmnand/Kconfig

-- 
2.25.1

