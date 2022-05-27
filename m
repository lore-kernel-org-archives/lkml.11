Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E77C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 May 2022 18:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354401AbiE0SoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 May 2022 14:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244925AbiE0SoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 14:44:05 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225E7101E7;
        Fri, 27 May 2022 11:44:04 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BF53C201D6A;
        Fri, 27 May 2022 20:44:02 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 885892013D7;
        Fri, 27 May 2022 20:44:02 +0200 (CEST)
Received: from lsv03121.swis.in-blr01.nxp.com (lsv03121.swis.in-blr01.nxp.com [92.120.146.118])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id EA32A180031F;
        Sat, 28 May 2022 02:44:00 +0800 (+08)
From:   Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        will@kernel.org, axboe@kernel.dk, robh+dt@kernel.org
Cc:     mb@lightnvm.io, ckeepax@opensource.cirrus.com, arnd@arndb.d,
        manjunatha.venkatesh@nxp.com, mst@redhat.com, javier@javigon.com,
        mikelley@microsoft.com, jasowang@redhat.com,
        sunilmut@microsoft.com, bjorn.andersson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        ashish.deshpande@nxp.com, rvmanjumce@gmail.com
Subject: [PATCH v4 0/2] Uwb: Nxp: Driver for SR1XX SOCs
Date:   Sat, 28 May 2022 00:13:48 +0530
Message-Id: <20220527184351.3829543-1-manjunatha.venkatesh@nxp.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a Fourth version of a Nxp Uwb SR1xx driver.
Following changes are done with respect to patch series.
- Device Tree Document for SR1XX SOCs patch added
- Maintainers list for Nxp SR1XX SOCs driver added
- sr1xx driver updated with previous review comments

Manjunatha Venkatesh (3):
  dt-bindings: uwb: Device tree information for Nxp SR1XX SOCs
  misc: uwb: Maintainers list for Nxp Uwb SR1XX SOCs family drivers
  misc: uwb: nxp: sr1xx: UWB driver support for sr1xx series chip

 .../bindings/uwb/nxp,uwb-sr1xx.yaml           |  67 ++
 MAINTAINERS                                   |   6 +
 drivers/misc/Kconfig                          |  12 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/nxp-sr1xx.c                      | 834 ++++++++++++++++++
 5 files changed, 920 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/uwb/nxp,uwb-sr1xx.yaml
 create mode 100644 drivers/misc/nxp-sr1xx.c

-- 
2.35.1

