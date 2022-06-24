Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18586C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jun 2022 18:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiFXS5D (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jun 2022 14:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiFXS5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:57:01 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B710681A31
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:57:00 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A988E240004;
        Fri, 24 Jun 2022 18:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656097019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=MFjFw8tUgIphkJRLvt6Qfe1VN4FzK9kVzbslGMkNXCs=;
        b=bAev8iF2GfpDBRxcNW/X2Ge/FOimUvaaQWxtqtP3sW/uCcTzlyHjNtkigWUAnZbleOAfhq
        +Fy+BVELr+GaXVdnwtOFqm/q75XM5Tk6homp7X08QElRTwVX50x2yBy/4+Tgv/jyOxVEgt
        3JmFusW+lwm2O9Yf8wTCuWq0Xr4PZPTo3NHjYyEV02Hk4Y8aE+07w48/Yk4HgITTBzEHw1
        rfZ1TRlq+p4P1jsqTmsS/xwxulMNw6hIru56fUQ2gLa6DKtiayQn2D5AI/xtm32u88VvqQ
        KAZi24ZUYRqBGZW7oEIuOA4Fk8jJYcFHZbs7L0sVSTaYWC5JolP8CvyxTICzjQ==
Date:   Fri, 24 Jun 2022 20:56:56 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Fixes for v5.19-rc4
Message-ID: <20220624205656.63c4e2b1@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.19-rc4

for you to fetch changes up to 06781a5026350cde699d2d10c9914a25c1524f45:

  mtd: rawnand: gpmi: Fix setting busy timeout setting (2022-06-16 16:46:08 +0200)

----------------------------------------------------------------
NAND controller fix:
* gpmi: Fix busy timeout setting (wrong calculation)

NAND chip driver fix:
* Thoshiba: Revert the commit introducing support for a chip that might
  have been counterfeit

----------------------------------------------------------------
Christian Lamparter (1):
      Revert "mtd: rawnand: add support for Toshiba TC58NVG0S3HTA00 NAND flash"

Sascha Hauer (1):
      mtd: rawnand: gpmi: Fix setting busy timeout setting

 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 2 +-
 drivers/mtd/nand/raw/nand_ids.c            | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)
