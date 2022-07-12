Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCE4C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jul 2022 13:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbiGLNQL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jul 2022 09:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiGLNQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:16:09 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF47C6BC11;
        Tue, 12 Jul 2022 06:16:02 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9E2BB22239;
        Tue, 12 Jul 2022 15:15:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1657631761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gLW7VatbrBWfqTwqY6WDck3eUofyP3Zra0rwZxER75Y=;
        b=RIdV6gkckEUDR0YgPzejBfRNOwh4cZw6hAmEoiw2lJnCq7LipAgAtHtBYwr0v/gQxOd7t4
        LpOmQbuVikpX7hei/Ia4edeLmtSnqJ9MXu/RMObAoHjDV8XUuAS2EdqfjXYpOktHcIVgVe
        eizEepdLqkBO+wezQGFYkPVyw44i5mg=
From:   Michael Walle <michael@walle.cc>
To:     Xu Liang <lxu@maxlinear.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH net-next 0/4] net: phy: mxl-gpy: version fix and improvements
Date:   Tue, 12 Jul 2022 15:15:50 +0200
Message-Id: <20220712131554.2737792-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the version reporting which was introduced earlier. The version will
not change during runtime, so cache it and save a PHY read on every auto
negotiation. Also print the version in a human readable form.

Michael Walle (4):
  net: phy: mxl-gpy: fix version reporting
  net: phy: mxl-gpy: cache PHY firmware version
  net: phy: mxl-gpy: rename the FW type field name
  net: phy: mxl-gpy: print firmware in human readable form

 drivers/net/phy/mxl-gpy.c | 55 +++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

-- 
2.30.2

