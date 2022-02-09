Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8AEC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 05:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbiBIFYj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Feb 2022 00:24:39 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiBIFXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 00:23:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD2FC0364AD;
        Tue,  8 Feb 2022 21:23:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7EDBB81E10;
        Wed,  9 Feb 2022 05:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5760AC340E7;
        Wed,  9 Feb 2022 05:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644384222;
        bh=Nhoe3V1CXXUihkcaoPOkIhLxTna/YcloEp90G75JeqA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F2jd30mp7QkdYFSXATqcBYf8h9GdD1ESTnYlFWJ1WtX0q31BmYxgY9kXLwPuOAdEe
         3qcBn+87FuW20I2R9PbQhlJ8OcSG7fXFtQ6kFccvKbF07YM2KKytPXM2HaaHnSN0bg
         Z/TwKCNC7N5H4ifUfHeznMGEa9pmm7sqdrHj1emqYG2dDmHkVlerPpexU2WU7tNX8/
         m6AeeQZEMT5zGPvqFFLH4pHrv4mf13KIr4sqOmaFUvg2dwp31AgOiHJgy/be1xFbHp
         Fz44tKBkelQJ+GomgSlYwwPv13BmOTE9F8N+Lhy2ENE5pxfavhgYl2rd6KWo4F9ue+
         K7GL5UWFj4P+Q==
Date:   Tue, 8 Feb 2022 21:23:41 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Moshe Shemesh <moshe@nvidia.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 0/4] net/mlx5: Introduce devlink param to
 disable SF aux dev probe
Message-ID: <20220208212341.513e04bf@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <1644340446-125084-1-git-send-email-moshe@nvidia.com>
References: <1644340446-125084-1-git-send-email-moshe@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Feb 2022 19:14:02 +0200 Moshe Shemesh wrote:
> $ devlink dev param set pci/0000:08:00.0 name enable_sfs_aux_devs \
>               value false cmode runtime
> 
> Create SF:
> $ devlink port add pci/0000:08:00.0 flavour pcisf pfnum 0 sfnum 11
> $ devlink port function set pci/0000:08:00.0/32768 \
>                hw_addr 00:00:00:00:00:11 state active
> 
> Now depending on the use case, the user can enable specific auxiliary
> device(s). For example:
> 
> $ devlink dev param set auxiliary/mlx5_core.sf.1 \
>               name enable_vnet value true cmde driverinit
> 
> Afterwards, user needs to reload the SF in order for the SF to come up
> with the specific configuration:
> 
> $ devlink dev reload auxiliary/mlx5_core.sf.1

If the user just wants vnet why not add an API which tells the driver
which functionality the user wants when the "port" is "spawned"?
