Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C355EC43334
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jun 2022 10:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355761AbiFVKx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jun 2022 06:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355318AbiFVKxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:53:41 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634D939B9A;
        Wed, 22 Jun 2022 03:53:39 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25MArGoX035546;
        Wed, 22 Jun 2022 05:53:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1655895196;
        bh=LScwQpN0cBg6TE3V982xv52Adis+BMVHwdnWq/v5bDg=;
        h=From:To:CC:Subject:Date;
        b=rRdcv1O/Y0bsQbY5iAuqlp/c3k6cxXADARQBI8tX4BbN27jMEqJOZ4rKOzygsCMvR
         rwH4c60aRpFbsPqf7TLXAferYlAGXWlUxq9Ey9NhVbeLobSV76GCUJw1FcO6RnXeaV
         Wwz3drGKEBd7JKtol+k6KRqOIkYkBg32SiwFARIc=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25MArGlT026664
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Jun 2022 05:53:16 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 22
 Jun 2022 05:53:16 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 22 Jun 2022 05:53:16 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25MArFRJ089927;
        Wed, 22 Jun 2022 05:53:15 -0500
From:   Rahul T R <r-ravikumar@ti.com>
To:     <linux-phy@lists.infradead.org>, <kishon@ti.com>,
        <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <laurent.pinchart@ideasonboard.com>
CC:     <p.yadav@ti.com>, <tomi.valkeinen@ideasonboard.com>,
        <linux-kernel@vger.kernel.org>, <jpawar@cadence.com>,
        <sjakhade@cadence.com>, <mparab@cadence.com>,
        <devicetree@vger.kernel.org>, <vigneshr@ti.com>,
        <lee.jones@linaro.org>, Rahul T R <r-ravikumar@ti.com>
Subject: [PATCH v3 0/3] Add support for dphy tx on j721e
Date:   Wed, 22 Jun 2022 16:23:08 +0530
Message-ID: <20220622105311.21415-1-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

following series of patches adds support for dphy tx on ti's j721e
soc. new compatible is added and required cdns dphy ops are implemented.
the series also adds band ctrl configuration required for dphy tx

v3:
-Fixed the header files order
-Store bands as array of unsigned int, since min[n] = max[n-1]
-Remove unreachable code warning

v2:
-fix a build error reported by kernel test robot <lkp@intel.com>
 which uses clang compiler. did not get the error with gnu toolchain
 9.2-2019.12

Rahul T R (3):
  phy: dt-bindings: cdns,dphy: Add compatible for dphy on j721e
  phy: cdns-dphy: Add band config for dphy tx
  phy: cdns-dphy: Add support for DPHY TX on J721e

 .../devicetree/bindings/phy/cdns,dphy.yaml    |   5 +-
 drivers/phy/cadence/Kconfig                   |  10 ++
 drivers/phy/cadence/cdns-dphy.c               | 102 +++++++++++++++++-
 3 files changed, 114 insertions(+), 3 deletions(-)

-- 
2.36.1

