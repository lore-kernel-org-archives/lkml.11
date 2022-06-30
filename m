Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1149C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jun 2022 14:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236945AbiF3OTT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jun 2022 10:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237344AbiF3OR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 10:17:59 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502504553A;
        Thu, 30 Jun 2022 07:02:48 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4162822236;
        Thu, 30 Jun 2022 16:02:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1656597766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5Q0/3Zp7gW4gT+Sw+FNUzkL95d+izWXUAdtdR88h4Rc=;
        b=VfJhf0myZO+bKRT/91LVbfEvPr3FZu+ii3IlCLv0tu5rqN6CDQvbi7RUzvxn78NXZifaIE
        PL7xHOYT11DdAn1bcSpJZEOc1ONExahrf4ZilNRXbin5UuELXJHeXO3SfOhyS5FlMeCtra
        JbRp5JRqZvIFca1c/HPkAxB2xQpTVaw=
From:   Michael Walle <michael@walle.cc>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH net-next 0/4] net: lan966x: hardcode port count
Date:   Thu, 30 Jun 2022 16:02:33 +0200
Message-Id: <20220630140237.692986-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't rely on the device tree to count the number of physical port. Instead
introduce a new compatible string which the driver can use to select the
correct port count.

This also hardcodes the generic compatible string to 8. The rationale is
that this compatible string was just used for the LAN9668 for now and I'm
not even sure the current driver would support the LAN9662.

Michael Walle (4):
  net: lan966x: hardcode the number of external ports
  dt-bindings: net: lan966x: add specific compatible string
  net: lan966x: add new compatible microchip,lan9668-switch
  ARM: dts: lan966x: use new microchip,lan9668-switch compatible

 .../net/microchip,lan966x-switch.yaml         |  5 +++-
 arch/arm/boot/dts/lan966x.dtsi                |  2 +-
 .../ethernet/microchip/lan966x/lan966x_main.c | 24 +++++++++++++------
 3 files changed, 22 insertions(+), 9 deletions(-)

-- 
2.30.2

