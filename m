Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCD2C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jul 2022 21:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbiGYVTI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jul 2022 17:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGYVTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:19:06 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0422223BF4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:19:05 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4LsCbF11XMzDv8s;
        Mon, 25 Jul 2022 21:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1658783945; bh=n8KC9Drv4LKMFsBlQF+V/6Us88hfUAPAucCxIVuKi0o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ff/7NQNayLHZj2xi3k3jPw9YWd5yay3T3dsFLkYjl/ezUP7Oo1hhmKI33GIwZD2bf
         4U0r/WDXv5oXmu7x9+fDBd5Hgj5K/WHeMRCuWzN4YxJPTlie5pvWK694H45xmXKyVA
         Ha+HomJT0L2T9pNUwliOcrV+5dHIQ2wfkL42Y/GE=
X-Riseup-User-ID: 6F9E402A612CAA97A7CF1A67268526495D3C6D9BDB0ED2759DF8CFF0AE335770
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4LsCb72N42z5vTk;
        Mon, 25 Jul 2022 21:18:59 +0000 (UTC)
Message-ID: <c6ef24e5-b090-fab7-a749-e259ad711012@riseup.net>
Date:   Mon, 25 Jul 2022 18:18:56 -0300
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] drm/amd/display: change variables type
Content-Language: en-US
To:     Magali Lemes <magalilemes00@gmail.com>, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     mwen@igalia.com, isabbasso@riseup.net, siqueirajordao@riseup.net,
        andrealmeid@riseup.net, tales.aparecida@gmail.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220725181559.250030-1-magalilemes00@gmail.com>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <20220725181559.250030-1-magalilemes00@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Magali

On 7/25/22 15:15, Magali Lemes wrote:
> As "dcn3_15_soc" and "dcn3_16_soc" are of type "struct
> _vcs_dpi_soc_bounding_box_st", change their types accordingly.
> 
> Signed-off-by: Magali Lemes <magalilemes00@gmail.com>
> ---

Great catch! To the whole series:

Reviewed-by: Maíra Canal <mairacanal@riseup.net>

Best Regards,
- Maíra Canal

>  drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h | 2 +-
>  drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h
> index 39929fa67a51..45276317c057 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h
> +++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h
> @@ -32,7 +32,7 @@
>  	container_of(pool, struct dcn315_resource_pool, base)
>  
>  extern struct _vcs_dpi_ip_params_st dcn3_15_ip;
> -extern struct _vcs_dpi_ip_params_st dcn3_15_soc;
> +extern struct _vcs_dpi_soc_bounding_box_st dcn3_15_soc;
>  
>  struct dcn315_resource_pool {
>  	struct resource_pool base;
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h
> index 0dc5a6c13ae7..d2234aac5449 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h
> +++ b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h
> @@ -32,7 +32,7 @@
>  	container_of(pool, struct dcn316_resource_pool, base)
>  
>  extern struct _vcs_dpi_ip_params_st dcn3_16_ip;
> -extern struct _vcs_dpi_ip_params_st dcn3_16_soc;
> +extern struct _vcs_dpi_soc_bounding_box_st dcn3_16_soc;
>  
>  struct dcn316_resource_pool {
>  	struct resource_pool base;
