Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A4EC54EE9
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Sep 2022 07:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbiIBH6Y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Sep 2022 03:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbiIBH6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:58:15 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B434EBCCDD;
        Fri,  2 Sep 2022 00:57:56 -0700 (PDT)
Received: (Authenticated sender: maxime.chevallier@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 316B524000A;
        Fri,  2 Sep 2022 07:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662105475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SEKGUH9XtqB9vWizlyyHba1yXsDRTZh/Ba89Xk69NGI=;
        b=DJIg2Xj3K+xGw9/89z/FYt1J/JXhaSujCOM0uCMxAWmv4aQdEvKhEiC8zI1yJ1rtkZramD
        cHurjMIJMYKhApo5ex7ZGdIgMPr15Bql1Y8hquf8uidhvj6Z3zP0wRLP9WKriyM9wtLu4V
        i6WTmITaKfR0HZeLtDnt4yRSB6wbx0bJTQ6Rf2dzX+s5d3GHMu9deE1T7nA9GBmHPlMorL
        lCLm4YWldo12tGbnzPEfSpHWytN0YudCIeqVxAM3ctz0K5ewzurlRK4m5GHZaAecwdhNvS
        I0mQLuMRM14iJx9Rlt5Td2w/ltiPX37Ip0OuWa1rgBbATTfDdi/627Xqe/JUUA==
Date:   Fri, 2 Sep 2022 09:57:49 +0200
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, Rob Herring <robh+dt@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/5] net: altera: tse: convert to phylink
Message-ID: <20220902095749.6af6af62@pc-10.home>
In-Reply-To: <20220901211021.52520588@kernel.org>
References: <20220901143543.416977-1-maxime.chevallier@bootlin.com>
        <20220901143543.416977-5-maxime.chevallier@bootlin.com>
        <20220901211021.52520588@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jakub,

On Thu, 1 Sep 2022 21:10:21 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu,  1 Sep 2022 16:35:42 +0200 Maxime Chevallier wrote:
> > This commit converts the Altera Triple Speed Ethernet Controller to
> > phylink. This controller supports MII, GMII and RGMII with its MAC,
> > and SGMII + 1000BaseX through a small embedded PCS.
> > 
> > The PCS itself has a register set very similar to what is found in a
> > typical 802.3 ethernet PHY, but this register set memory-mapped
> > instead of lying on an mdio bus.  
> 
> allmodconfig builds report:
> 
> ERROR: modpost: missing MODULE_LICENSE() in
> drivers/net/pcs/pcs-altera-tse.o

Ah you're right, I forgot to specify it. I'll address that in the next
version, thanks !

Maxime
