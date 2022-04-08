Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C4AC433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Apr 2022 13:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbiDHNhn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Apr 2022 09:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236291AbiDHNhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:37:36 -0400
Received: from louie.mork.no (louie.mork.no [IPv6:2001:41c8:51:8a:feff:ff:fe00:e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7055A2F429E;
        Fri,  8 Apr 2022 06:35:30 -0700 (PDT)
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:c9f:8600:0:0:0:1])
        (authenticated bits=0)
        by louie.mork.no (8.15.2/8.15.2) with ESMTPSA id 238DZEaD542723
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
        Fri, 8 Apr 2022 14:35:15 +0100
Received: from miraculix.mork.no ([IPv6:2a01:799:c9f:8602:8cd5:a7b0:d07:d516])
        (authenticated bits=0)
        by canardo.dyn.mork.no (8.15.2/8.15.2) with ESMTPSA id 238DZDlN2391998
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
        Fri, 8 Apr 2022 15:35:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1649424913; bh=dNK6QvzfkB+BZ2rLeGGl1RWUm0ala0WHo/wVB47NP18=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=ljt89BOxjAHcCO0CHlTHJLHmsDv7Fn7I2qmSTwJYpLga/lyrHn4Eay9jLyTwwmcVQ
         Hpe9hn/xYSzin0htvQwljku53u2vOM9g8uz67dhz/++tMq8yBTPaJ2AdKRgAZQe1Wa
         QTVTPWm1mYLw/H0QWmua3VphyvPvW2DUp4Ls9FQI=
Received: (nullmailer pid 762927 invoked by uid 1000);
        Fri, 08 Apr 2022 13:35:13 -0000
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     Lars Melin <larsm17@gmail.com>
Cc:     sven@svenschwermer.de, linux-usb@vger.kernel.org,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        linux-kernel@vger.kernel.org, oliver@neukum.org
Subject: Re: [PATCH v1 2/2] net: usb: cdc_ether: Add Fibocom MA510 modem
Organization: m
References: <20220407074745.74195-1-sven@svenschwermer.de>
        <20220407074745.74195-2-sven@svenschwermer.de>
        <3b8a8497-df41-8bf4-6816-f4419cb7f950@gmail.com>
Date:   Fri, 08 Apr 2022 15:35:13 +0200
In-Reply-To: <3b8a8497-df41-8bf4-6816-f4419cb7f950@gmail.com> (Lars Melin's
        message of "Fri, 8 Apr 2022 08:15:00 +0700")
Message-ID: <87ee27y9ym.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.5 at canardo
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lars Melin <larsm17@gmail.com> writes:

> Why do you add this modem to the whitelist?

I believe the clue is the

> +	.driver_info =3D (unsigned long)&wwan_info,

to set FLAG_WWAN instead of the default FLAG_ETHER | FLAG_POINTTOPOINT

> The net interface has the correct cdc_ether attributes so the
> cdc_ether driver should bind automagically without any need for the
> modem to be in the whitelist.

Yes, this sort of works against the class driver philosophy.  But we've
already started down that road, so...



Bj=C3=B8rn
