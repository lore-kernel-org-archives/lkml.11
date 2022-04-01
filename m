Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3818AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Apr 2022 18:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236339AbiDAS0J (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Apr 2022 14:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbiDAS0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:26:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126DE17FD3E;
        Fri,  1 Apr 2022 11:24:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4955B825B1;
        Fri,  1 Apr 2022 18:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643DDC340EE;
        Fri,  1 Apr 2022 18:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648837453;
        bh=rcBit4D+cJoPaMnAkofaQ1xtj/Y+I4p055Ym5x4wpfg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=RHgJE8FS1xd73mO0tEcxy32mK8k0oW+n5FvSrRwp7qXoCHklunZnWADnIxsgwHIkx
         LSFEc8hkCjv6tHrZp8kOKfD3Sh34+R8VuWKmHeXT1cE9+Ru5aSOvubifCsmPUWgvO8
         2uD8kjzvMZPcQY4IbzO3rIWu9T9GAZZ/tMn/GCx6AjvjJpf89wObMEcMxTt2OsGKwb
         EUn+Up6C/MUZjFApbX4rlQ0eOVEVMp+FXnwZ6RlkXKXXbcHM/Gh6+ZPaHQ3BmXmKcv
         9ROrR2SNVB/R5DVLrk58YeiCLevP5lQsukCQRa5nAeojjWdmavQZzh4nHJF9mnSfag
         rybfMxJ6QHerQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3107512.vfdyTQepKt@diego>
References: <20220329111323.3569-1-jbx6244@gmail.com> <20220331225134.7A0A9C340ED@smtp.kernel.org> <3107512.vfdyTQepKt@diego>
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: convert rockchip,rk3188-cru.txt to YAML
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>, zhangqing@rock-chips.com
Date:   Fri, 01 Apr 2022 11:24:11 -0700
User-Agent: alot/0.10
Message-Id: <20220401182413.643DDC340EE@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Heiko St=C3=BCbner (2022-04-01 00:55:55)
> Hi Stephen,
>=20
> Am Freitag, 1. April 2022, 00:51:32 CEST schrieb Stephen Boyd:
> > Quoting Johan Jonker (2022-03-29 04:13:22)
> > > diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3188-=
cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml
> > > new file mode 100644
> > > index 000000000..ddd7e46af
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml
> > > @@ -0,0 +1,78 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/clock/rockchip,rk3188-cru.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Rockchip RK3188/RK3066 Clock and Reset Unit (CRU)
> > > +
> > > +maintainers:
> > > +  - Elaine Zhang <zhangqing@rock-chips.com>
> > > +  - Heiko Stuebner <heiko@sntech.de>
> > > +
> > > +description: |
> > > +  The RK3188/RK3066 clock controller generates and supplies clocks t=
o various
> > > +  controllers within the SoC and also implements a reset controller =
for SoC
> > > +  peripherals.
> > > +  Each clock is assigned an identifier and client nodes can use this=
 identifier
> > > +  to specify the clock which they consume. All available clocks are =
defined as
> > > +  preprocessor macros in the dt-bindings/clock/rk3188-cru.h and
> > > +  dt-bindings/clock/rk3066-cru.h headers and can be used in device t=
ree sources.
> > > +  Similar macros exist for the reset sources in these files.
> > > +  There are several clocks that are generated outside the SoC. It is=
 expected
> > > +  that they are defined using standard clock bindings with following
> > > +  clock-output-names:
> > > +    - "xin24m"    - crystal input                 - required
> > > +    - "xin32k"    - RTC clock                     - optional
> > > +    - "xin27m"    - 27mhz crystal input on RK3066 - optional
> > > +    - "ext_hsadc" - external HSADC clock          - optional
> > > +    - "ext_cif0"  - external camera clock         - optional
> > > +    - "ext_rmii"  - external RMII clock           - optional
> > > +    - "ext_jtag"  - external JTAG clock           - optional
> >=20
> > I'd expect all these clks here to be inputs to this node.
>=20
> The optional clocks are all part of a circular dependency.
>=20
> So for example xin32k normally is generated by the pmic and fed
> back into the system, so to get xin32k, we need the pmic to probe,
> which needs i2c, which in turn already needs the clock controller.
>=20
> Or optional clocks may not be available at all.
>=20
> So for the past years we already relied on the clock-system's
> self adaptation if a clock becomes available at some point
> during later boot and hence do not have those in a clocks-property.
>=20

Are you saying that we can't have these clks in the clocks property
because there's a circular driver probe dependency? I don't see how that
matters for the dt binding. What is broken if they're put in the binding
and specified in the node?
