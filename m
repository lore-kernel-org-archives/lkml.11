Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2419EC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jun 2022 14:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbiFSOMR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jun 2022 10:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbiFSOMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 10:12:12 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7956B840;
        Sun, 19 Jun 2022 07:12:09 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 3BCE71C0B8F; Sun, 19 Jun 2022 16:12:07 +0200 (CEST)
Date:   Sun, 19 Jun 2022 16:12:02 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     sboyd@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, mturquette@baylibre.com, linux@armlinux.org.uk,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v18 10/10] ARM: dts: Add Sunplus SP7021-Demo-V3 board
 device tree
Message-ID: <20220619141202.GA1197@bug>
References: <cover.1655194858.git.qinjian@cqplus1.com>
 <0574ed0ad1e9ec4c12645fe2d2dde8f701d285e5.1655194858.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <0574ed0ad1e9ec4c12645fe2d2dde8f701d285e5.1655194858.git.qinjian@cqplus1.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +	led {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&leds_pins>;
> +		system-led {
> +			label = "system-led";
> +			gpios = <&pctl 0 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};

Can we get label more in line with other systems?

Thanks,
								Pavel

-- (english) http://www.livejournal.com/~pavelmachek (cesky, pictures) 
http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
