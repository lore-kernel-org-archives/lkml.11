Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711B3C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Apr 2022 23:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243165AbiDJXCt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Apr 2022 19:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbiDJXCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 19:02:37 -0400
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9212917056;
        Sun, 10 Apr 2022 16:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:From:Reply-To:Subject:Content-ID:
        Content-Description:In-Reply-To:References:X-Debbugs-Cc;
        bh=H5rYQQZTVbwBGqFOdWYp6vWsZ00yzYqWcc7DygnQfQw=; b=ooeMpdp3oxFm2vcEwmxzbIYTje
        ZxE5b7FawkWEkEdx4fvfueCX78iyCQXfPqve9tN4sJRsMDIbUKFl18Iuc1TQl315zXJIF9CyNSKbH
        FRznsBNYD/vZLhcI3s8UsQgNN1VKSmM8tJwEG+wifwVe/kwjlEovvvGKGEJHsgA6XAwhED3NpY81i
        NrdPVMFWYOxnF8JnCd0DYM2yrYzcFCgwk09j5vrG11HVitrNjn+AfOVmJX/L6GitS/0AnqgblA+ku
        kYg59O6/7UAIyFiZSzd4Mj/Dv2FXz5bqKhRzTcw2s/C5E0CVrew0cqwJ/uHXr501Z3SiP/Mz0O80v
        1xiZqLWQ==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1ndgXc-00BKcL-Pm; Mon, 11 Apr 2022 01:00:20 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.95)
        (envelope-from <aurelien@aurel32.net>)
        id 1ndgXc-000ZMS-3P;
        Mon, 11 Apr 2022 01:00:20 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     linux-kernel@vger.kernel.org
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, soc@kernel.org
Subject: [PATCH 0/2] arm/arm64: dts: Enable device-tree overlay support for RPi devices
Date:   Mon, 11 Apr 2022 00:59:38 +0200
Message-Id: <20220410225940.135744-1-aurelien@aurel32.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset changes the generation of the Raspberry Pi devices DTB
files to improve the support for out-of-tree device-tree overlays, like
it has recently been done for the Nvidia SoCs.

I personally only need that for arm64, but I have added a similar patch
to do the same on arm.

Aurelien Jarno (2):
  arm64: dts: broadcom: Enable device-tree overlay support for RPi
    devices
  arm: dts: Enable device-tree overlay support for RPi devices

 arch/arm/boot/dts/Makefile            | 18 ++++++++++++++++++
 arch/arm64/boot/dts/broadcom/Makefile | 11 +++++++++++
 2 files changed, 29 insertions(+)

-- 
2.34.1

