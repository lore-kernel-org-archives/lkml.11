Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF5CC43334
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jun 2022 10:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240643AbiFTKCW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jun 2022 06:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239916AbiFTKCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:02:19 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E1213E3F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 03:02:18 -0700 (PDT)
Received: from [192.168.1.111] (91-158-154-79.elisa-laajakaista.fi [91.158.154.79])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 24368883;
        Mon, 20 Jun 2022 12:02:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1655719335;
        bh=60p2CqtNr66jvuLK0BdcB2OQbzGSe2KUrAuZHRtXCrA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bz5j/Es+f5ML3hisYSfAifn6RTIxoh9WZW6FEDR0mCI5tqN2MJ9IP1xofsmbRbLpT
         VjYHLIZkKEVlByPil2uF9Q0rgZ4yfQO2zdgh/BdoTWycphhicLjRS90cKKBcYdQfvZ
         3srldnsIg7uMfTSGqzf9tsv0dL1sJrqlq2chh2Go=
Message-ID: <042c77d5-7db1-fa09-4be4-74dbfa85b5e2@ideasonboard.com>
Date:   Mon, 20 Jun 2022 13:02:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] drm/bridge: cdns-dsi: Add support for J721E wrapper
Content-Language: en-US
To:     Rahul T R <r-ravikumar@ti.com>, dri-devel@lists.freedesktop.org
Cc:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, jonas@kwiboo.se, jernej.skrabec@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch, p.zabel@pengutronix.de,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        jpawar@cadence.com, sjakhade@cadence.com, mparab@cadence.com,
        a-bhatia1@ti.com
References: <20220619140158.30881-1-r-ravikumar@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20220619140158.30881-1-r-ravikumar@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19/06/2022 17:01, Rahul T R wrote:
> Add support for wrapper settings for DSI bridge on
> j721e. Also set the DPI input to DPI0
> 
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> ---

Nack... This wouldn't work with some other SoC using CDNS DSI.

See cdns-mhdp8546 for an example of a bit more generic wrapper support.

  Tomi
