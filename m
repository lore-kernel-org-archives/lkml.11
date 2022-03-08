Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955A1C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 01:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344235AbiCHBTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Mar 2022 20:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238576AbiCHBT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 20:19:29 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CF836E22;
        Mon,  7 Mar 2022 17:18:31 -0800 (PST)
Received: from hatter.bewilderbeest.net (174-21-187-98.tukw.qwest.net [174.21.187.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 88DB04C8;
        Mon,  7 Mar 2022 17:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1646702310;
        bh=WA0g01ylI3uRFuxsoi3Sd/kmAWCJhNXmCT+GLDXKrng=;
        h=From:To:Cc:Subject:Date:From;
        b=SZNk3TyQOZhh0La1+PbuuAmh0QkAcMusjnejTEgP1Jtip5aWdNrM7TvXDaleiYAXK
         4JfZiX5YIKSxw8wiHovUOS/eKTh9eXOjA57LYz/8irtXvFiiJ4WXyuJKSujRPfhW5R
         f09morTBdSS0o3gNVvohpJuseqFlC/PmNXZjwzRM=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Zev Weiss <zev@bewilderbeest.net>, openbmc@lists.ozlabs.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v2 0/2] misc: Add power-efuse driver
Date:   Mon,  7 Mar 2022 17:18:08 -0800
Message-Id: <20220308011811.10353-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is a second revision of the v1 patch series posted previously
[2].

Changes since v1:
 - dropped pmbus/lm25066 patches, submitted separately via hwmon tree [Guenter]
 - fixed indentation in power-efuse.yaml [Rob's bot]
 - added more detailed description in power-efuse.yaml [Rob]
 - added sysfs ABI documentation [Greg]
 - replaced manual struct attribute_group and sysfs_create_group()
   with ATTRIBUTE_GROUPS() and driver.dev_groups [Greg]

A lightly edited version of the previous cover letter follows.


This patch series is another incarnation of some previous efforts [0]
at enabling userspace access to the OPERATION state (and now status
flags) of PMBus devices, specifically with respect to efuses
protecting general-purpose power outputs.  This functionality is an
important component enabling a port of OpenBMC to the Delta AHE-50DC
Open19 power shelf [1].

The first patch adds dt-bindings, and the second adds the
implementation of the power-efuse driver.  The driver is fairly
simple; it merely provides a sysfs interface to enable, disable, and
retrieve error flags from an underlying regulator (which in the
expected usage will most likely be a PMBus device).

There is one aspect of its usage of the regulator API I'm a bit
uncertain about, however: this driver seems like a case where an
exclusive 'get' of the regulator (i.e. devm_regulator_get_exclusive()
instead of devm_regulator_get() in efuse_probe()) would be
appropriate, since in the intended usage no other device should be
using an efuse's regulator.  With an exclusive get though, the
regulator's use_count and the consumer's enable_count don't balance
out properly to allow the enable/disable operations to work properly
(the former ending up one more than the latter, leading to
enable_count underflows on attempts to disable the regulator).  So at
least for now it's using a non-exclusive get -- I'd be happy to hear
any pointers on a way to allow an exclusive get to work here, though.


Thanks,
Zev

[0] https://lore.kernel.org/openbmc/YGLepYLvtlO6Ikzs@hatter.bewilderbeest.net/
[1] https://www.open19.org/marketplace/delta-16kw-power-shelf/
[2] https://lore.kernel.org/openbmc/20220217104444.7695-1-zev@bewilderbeest.net/

Zev Weiss (2):
  dt-bindings: Add power-efuse binding
  misc: Add power-efuse driver

 .../ABI/testing/sysfs-driver-power-efuse      |  32 +++
 .../devicetree/bindings/misc/power-efuse.yaml |  49 ++++
 MAINTAINERS                                   |   5 +
 drivers/misc/Kconfig                          |  15 ++
 drivers/misc/Makefile                         |   1 +
 drivers/misc/power-efuse.c                    | 212 ++++++++++++++++++
 6 files changed, 314 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-power-efuse
 create mode 100644 Documentation/devicetree/bindings/misc/power-efuse.yaml
 create mode 100644 drivers/misc/power-efuse.c

-- 
2.35.1

