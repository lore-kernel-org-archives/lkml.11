Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E87C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Apr 2022 21:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbiD0Vrk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Apr 2022 17:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbiD0Vr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 17:47:29 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369A96F9D9;
        Wed, 27 Apr 2022 14:44:16 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id ACF4422249;
        Wed, 27 Apr 2022 23:44:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1651095855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yuw6ibN9HAScxt+7YnLDUvnWFI0/6cH4XqlnH+83wL8=;
        b=UiqNIOiKsh3pp7R8B0j+n10TTvXSReWpYvBQUnq8abWzNCi52RPgRf2Whcbo8LmT0YYHR3
        wjRYa0HrAxE0Re8LfWkFvegQypVyoTcgKit9MBUJm3YhWi5AKspolShE9JO0VU62lbDFq6
        peygjg+TCQzT+729BeKwhvLlvVodD60=
From:   Michael Walle <michael@walle.cc>
To:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH net-next v1 0/3] net: phy: micrel: add coma mode support
Date:   Wed, 27 Apr 2022 23:44:03 +0200
Message-Id: <20220427214406.1348872-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to disable coma mode by a GPIO line.

Michael Walle (3):
  dt-bindings: net: micrel: add coma-mode-gpios property
  net: phy: micrel: move the PHY timestamping check
  net: phy: micrel: add coma mode GPIO

 .../devicetree/bindings/net/micrel.txt        |  9 ++++++
 drivers/net/phy/micrel.c                      | 32 ++++++++++++++++---
 2 files changed, 37 insertions(+), 4 deletions(-)

-- 
2.30.2

