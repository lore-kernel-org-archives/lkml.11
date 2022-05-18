Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101B9C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 18 May 2022 00:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbiERAz0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 20:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbiERAzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 20:55:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA7353B58;
        Tue, 17 May 2022 17:55:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF4DBB81DD8;
        Wed, 18 May 2022 00:55:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D4AC385B8;
        Wed, 18 May 2022 00:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652835321;
        bh=I2xjX76KsRn9y3/72Q0rtJUBVNTqbOU3T94kelSJog8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T9UbxJ8Klh/EgCdyXMO82XiFOIvMWVeXWjNMy7JSjL1bexlNwEJIfr83hUqPzaCmv
         E3125vx/fhxg8aia53tUAnD+jh2CFsODhr6nY5xMYlYq6hwR35em88R+xiAPdQ7m7b
         vetrxi5KmE0dCALGplhcjSaOSE2iWzcYqYCvK29hZOIGJVLM50cWLWNyn+F/10JqKB
         uOt7tD6zUaA9kmyfiI6o9TjUf4vRN9hQja7lqXuzBSHfUdhecq42MtHOEz5LvcqHaK
         oyLiDS9YWHfOQUaNcNDFIFV92dKKoqWt2xf3EHK0jYoF46N/0kNrEiAqMw6tqTXsD9
         vPxA26JWopNtA==
Date:   Tue, 17 May 2022 17:55:19 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Peng Wu <wupeng58@huawei.com>
Cc:     <davem@davemloft.net>, <edumazet@google.com>,
        <hkallweit1@gmail.com>, <bhelgaas@google.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liwei391@huawei.com>
Subject: Re: [PATCH] sfc/siena: fix driver suspend/resume methods
Message-ID: <20220517175519.0b04e58b@kernel.org>
In-Reply-To: <20220517012334.122677-1-wupeng58@huawei.com>
References: <20220517012334.122677-1-wupeng58@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2022 01:23:34 +0000 Peng Wu wrote:
> Fix the missing pci_disable_device() before return
> from efx_pm_resume() in the error handling case.
> 
> Meanwhile, drivers should do this:
> .resume()
> 	pci_enable_device()
> .suspend()
> 	pci_disable_device()
> 
> Signed-off-by: Peng Wu <wupeng58@huawei.com>

Won't the remove function no disable the device, anyway?

If the patch is indeed needed please add a Fixes tag pointing to where
the buggy code was added and repost.

Also since this file is a copy of drivers/net/ethernet/sfc/efx.c
I'm not sure why you're only patching this instance but not the
original.
