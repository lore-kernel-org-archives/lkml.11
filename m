Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48699C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 03:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244612AbiCODKG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 23:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiCODKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 23:10:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2EA1275E;
        Mon, 14 Mar 2022 20:08:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D2E4B80F96;
        Tue, 15 Mar 2022 03:08:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AEFC340E9;
        Tue, 15 Mar 2022 03:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647313732;
        bh=eandmSBxzPDmAo5AXfjj/Jusa0C9e0IOWab7VNhXnGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XBjk8o1Cv4SMbJ2yaN3mlQPQvDUCqftHwDA9TPK7uBVXXXpw73OgKiu+RPmiU2GOI
         4ZCko1xNgGxle4LP51iUVrOl5tah8hrDXFZyjOiluHH3gkl+xoxFSSPhJegJ4Vsp6i
         a5gIdQFaHXYlFChsttfC/+JwxRpb3oWCCIfaAsyiCup6Q/fY/HBg8Uk7EPQVBfLH2S
         0V07hnPxTKidw6iAZEIQiWaOsaR1DJfPFt5UceqUXBA8xpxL+YoSp5Z43f3z9pIvMb
         3O/ZAzTzqn+hS+N2jWKecn3dEdqWoZRPIdezEV5qKSdvl78IPiuzsLFXHrfWPuIXMv
         0Wt4yPC3Dp1wA==
Date:   Tue, 15 Mar 2022 11:08:47 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org,
        chrome-platform@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>
Subject: Re: [PATCH 1/2] dt-bindings: mfd: Add ChromeOS fingerprint binding
Message-ID: <YjADP+8mNnlkcGF7@google.com>
References: <20220314232214.4183078-1-swboyd@chromium.org>
 <20220314232214.4183078-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314232214.4183078-2-swboyd@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 04:22:13PM -0700, Stephen Boyd wrote:
> Add a binding to describe the fingerprint processor found on Chromeboks
> with a fingerprint sensor.

Nit: s/Chromeboks/Chromebooks/.

> +properties:
> +  compatible:
> +    const: google,cros-ec-fp

Not sure if it could make sense for FPS with other interfaces: would
cros-ec-fp-spi or cros-ec-spi-fp be a better name?  I am wondering because
there are cros-ec-spi specific properties "google,cros-ec-spi-pre-delay" and
"google,cros-ec-spi-msg-delay" in the binding.

> +  reset-gpios:
> +    maxItems: 1
> +    description: reset signal (active low).
> +
> +  boot0-gpios:
> +    maxItems: 1
> +    description: boot signal (low for normal boot; high for bootloader).
> +
> +  vdd-supply:
> +    description: Power supply for the fingerprint controller.

To be consistent: s/Power/power/.
