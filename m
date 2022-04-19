Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AA2C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Apr 2022 12:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352217AbiDSMWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Apr 2022 08:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240032AbiDSMWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:22:11 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8041C2A245
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:19:29 -0700 (PDT)
Received: from [192.168.1.111] (91-156-85-209.elisa-laajakaista.fi [91.156.85.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E4D0B25B;
        Tue, 19 Apr 2022 14:19:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1650370767;
        bh=asb053ePNHSoO5X2MGY+KrnehLTOpLIt9thiLRtfkbQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=T5WyU+wo2wpZze3wYc0MDkCEUm0xbsVHM6DQkXL0qHAPr0ArBAXEdar3dEkosKeWn
         80xKkAdkgwn14UpzgXUmIG5U4na19IwWHbX8AeVoUNAgiL1gitiptWw9g7ygs85RAP
         kZKQtMCRgMtwki85chRsTm7Im8yLt97oCqptLBFA=
Message-ID: <28e229e4-c4d1-e7ae-5150-84a4b45e14ef@ideasonboard.com>
Date:   Tue, 19 Apr 2022 15:19:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/tidss: Soft Reset DISPC on startup
Content-Language: en-US
To:     Devarsh Thakkar <devarsht@ti.com>, linux-kernel@vger.kernel.org,
        jyri.sarha@iki.fi, tomba@kernel.org, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     nm@ti.com, a-bhatia1@ti.com, r-ravikumar@ti.com, nikhil.nd@ti.com,
        linux-arm-kernel@lists.infradead.org, vigneshr@ti.com,
        laurent.pinchart@ideasonboard.com
References: <20220314113739.18000-1-devarsht@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20220314113739.18000-1-devarsht@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2022 13:37, Devarsh Thakkar wrote:
> Soft reset the display subsystem controller on startup and wait for
> the reset to complete. This helps the scenario where display was
> already in use by some other core before the linux was booted.
> 
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
>   drivers/gpu/drm/tidss/tidss_dispc.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 

Thanks, I have pushed this to drm-misc-next.

  Tomi

