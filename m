Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D5EC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 17:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243344AbiESRuR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 13:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243370AbiESRs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:48:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAACBA57A;
        Thu, 19 May 2022 10:48:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6F16618EC;
        Thu, 19 May 2022 17:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3DAC36AF2;
        Thu, 19 May 2022 17:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652982534;
        bh=+r1r8GFRbG7ATP7YpPleCIYRYj+oHJ89RWr+aaridB4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ab9WIT7Oa7Yx9M9CyQc4rJigtQ6df4mzWw2T2AJXMBJvDxKh0Gk3lCzJRy9UhvoTb
         y9VoA+mW1lJM3edBHE9MRLt9j9kn+HZzhm0dKDVpF3EbqilnEcHPYqwaAmweUIKb6t
         fcV4/Frq1VuWA+CHQNPKlWt0pCX2Mp+Iee0kzW41Vbi8zNs0BhccPtd/RFb4JBeB3P
         IYq8b5HQDLMp1JqzhW6IEt0mePqI0II1D2GD5MMzt9fxjtYMStMAIGyXd+KYXsSBAd
         vEGVnIxkJcM6l6zNoKZUW+nbJFCFS49VakIev7XUyYrCNH1MARgu0hJyFv/j3D3T4z
         GjlFyN4x48EQQ==
Date:   Thu, 19 May 2022 10:48:52 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Saeed Mahameed <saeedm@nvidia.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Shay Drory <shayd@nvidia.com>
Subject: Re: linux-next: manual merge of the rdma tree with the net tree
Message-ID: <20220519104852.0b6afa26@kernel.org>
In-Reply-To: <20220519040345.6yrjromcdistu7vh@sx1>
References: <20220519113529.226bc3e2@canb.auug.org.au>
        <20220519040345.6yrjromcdistu7vh@sx1>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2022 21:03:45 -0700 Saeed Mahameed wrote:
> >@@@ -1274,9 -1252,7 +1261,7 @@@ static void mlx5_unload(struct mlx5_cor
> >  	mlx5_ec_cleanup(dev);
> >  	mlx5_sf_hw_table_destroy(dev);
> >  	mlx5_vhca_event_stop(dev);
> > -	mlx5_cleanup_fs(dev);
> > +	mlx5_fs_core_cleanup(dev);
> >- 	mlx5_accel_ipsec_cleanup(dev);
> >- 	mlx5_accel_tls_cleanup(dev);
> >  	mlx5_fpga_device_stop(dev);
> >  	mlx5_rsc_dump_cleanup(dev);
> >  	mlx5_hv_vhca_cleanup(dev->hv_vhca);  
> 
> I already mentioned this to the netdev maintainers, same conflict should
> appear in net-next, this is the correct resolution, Thanks Stephen.

FTR could you not have held off the mlx5_$verb_fs() -> mlx5_fs_$verb
rename until net-next? This conflict looks avoidable :/
