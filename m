Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1507CC433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Mar 2022 13:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356014AbiCPNKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Mar 2022 09:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239772AbiCPNKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:10:11 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745FE27FC6;
        Wed, 16 Mar 2022 06:08:57 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id dr20so4019795ejc.6;
        Wed, 16 Mar 2022 06:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jDdo77E6bodwKomBqhyh/QFbllXF/eggXHy1SBgzqKk=;
        b=KfJPqoODp5vXC/0ovUiSuFkJy9qoA9TeDaui0xqOmSWNJSPOdDZs6WG5GyEFkncY2V
         qYne3m0ITU6LzsON/W5Y7OJ9VQL06vDxvGRLCyAIrLmSRXHLVgr4Y7urfOOm0QXAg0QC
         pgKO/UZ7ADGlAQg4a9OCJXtesou/jdZbk9QKNd9teK30f7UWJDWyZWSPR0rpzRhVOGkX
         h0u9s9YNAqOz2i8/uyd0fuwLHsDIGSbG5XbPBbeO2B4leWNxGAXuXIttZiJADMtyhf6y
         1dgLlnQNzflL/cZRiKXOMVg5yQeRpJJNtnPUIdHil2QbnOZydEwzk013SaVI6wsAKsNQ
         ncTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jDdo77E6bodwKomBqhyh/QFbllXF/eggXHy1SBgzqKk=;
        b=BWQZIbemJ/wISHgtNq54r3/iBjTH91Y7pwiYhh6Gw2SPkj2OdFWzN75AOZ1iUSslsE
         wAUp/vOkkerkmLTINDcJ2M2pw1MONCfj6TLNc1dyKZ5YFtZWmX/111GAalWESkLKnVQP
         7fINNWYZFY9sWYFNnhXiyXjXb/GgZozXXkKVteWy/VCt6RsoOvdtYbLXaSgBh70z/uSO
         WjMfqQ7aiOyG3jZwmZEyOEDh2B9Yesh/moYfHuCDNIQUGlJpcYJCYp+j0/4kNgbvPlIZ
         +eHtGWpiKEKmwQ1l0agl2vRNrvSpK8J3/caVtTpXkaWQMiHCaB+15HobI5bVt3/AFMgq
         VJJg==
X-Gm-Message-State: AOAM531kjxYCWhWUvY3nwPhAbbJX/wPYeu/+CZ3L4C+YZmJ6STOia/ns
        7ADWP+1JjOxD2CTkC4Z0QMY=
X-Google-Smtp-Source: ABdhPJx+jBX6oHN4EG2/kgYKkkBWSOOnoD8t2IR/Q650mW+5jb8RfbrPvQbLJrUxjy41H6tWiuSAug==
X-Received: by 2002:a17:907:1c16:b0:6d7:622b:efea with SMTP id nc22-20020a1709071c1600b006d7622befeamr26957234ejc.110.1647436133169;
        Wed, 16 Mar 2022 06:08:53 -0700 (PDT)
Received: from skbuf ([188.26.57.45])
        by smtp.gmail.com with ESMTPSA id d7-20020a50cd47000000b004187eacb4d6sm970570edj.37.2022.03.16.06.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 06:08:52 -0700 (PDT)
Date:   Wed, 16 Mar 2022 15:08:51 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Tobias Waldekranz <tobias@waldekranz.com>
Cc:     davem@davemloft.net, kuba@kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next] net: dsa: Never offload FDB entries on
 standalone ports
Message-ID: <20220316130851.nrevmuktxuzkgxd3@skbuf>
References: <20220315233033.1468071-1-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315233033.1468071-1-tobias@waldekranz.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 12:30:33AM +0100, Tobias Waldekranz wrote:
> If a port joins a bridge that it can't offload, it will fallback to
> standalone mode and software bridging. In this case, we never want to
> offload any FDB entries to hardware either.
> 
> Previously, for host addresses, we would eventually end up in
> dsa_port_bridge_host_fdb_add, which would unconditionally dereference
> dp->bridge and cause a segfault.
> 
> Fixes: c26933639b54 ("net: dsa: request drivers to perform FDB isolation")
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

>  net/dsa/slave.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/dsa/slave.c b/net/dsa/slave.c
> index f9cecda791d5..d24b6bf845c1 100644
> --- a/net/dsa/slave.c
> +++ b/net/dsa/slave.c
> @@ -2847,6 +2847,9 @@ static int dsa_slave_fdb_event(struct net_device *dev,
>  	if (ctx && ctx != dp)
>  		return 0;
>  
> +	if (!dp->bridge)
> +		return 0;
> +
>  	if (switchdev_fdb_is_dynamically_learned(fdb_info)) {
>  		if (dsa_port_offloads_bridge_port(dp, orig_dev))
>  			return 0;
> -- 
> 2.25.1
> 
