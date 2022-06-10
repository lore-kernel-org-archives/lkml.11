Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FE3C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jun 2022 13:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbiFJNtg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 09:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiFJNtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 09:49:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE583701D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 06:49:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A6D961BEA
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 13:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29442C34114;
        Fri, 10 Jun 2022 13:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654868970;
        bh=wHtwYyPgUt58voO96nG2HAAXty3aJt4cYSYt0GOwafM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eyM6Paq16QKPgUOWyYbTUZ+KqNoUVYGvu+SlhWQv2or1Y7KPknO6GlcWIaRRiKuCV
         J6jFeXekb6YMPPJTnItWniuiOZhjd4hdIBjJ52mJzWpDLHETzNuSnGa9+CChUkjsbr
         geYrqQtK7DLdxXrDcI53HQ8fh3T7ZW3hRF24iKk4=
Date:   Fri, 10 Jun 2022 15:49:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhang Wensheng <zhangwensheng5@huawei.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com
Subject: Re: [PATCH -next] driver core: fix deadlock in __driver_attach
Message-ID: <YqNL6NPgP+cLOy/I@kroah.com>
References: <20220608094355.3298420-1-zhangwensheng5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608094355.3298420-1-zhangwensheng5@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 05:43:55PM +0800, Zhang Wensheng wrote:
> In __driver_attach function, There are also potential AA deadlock
> problem, like the commit b232b02bf3c2 ("driver core: fix deadlock
> in __device_attach").

Potential, but real?

And the codepaths for drivers being added is much different than
devices, please provide the full information like you did in the other
commit.

Also, have you triggered this problem successfully and proven that this
change fixes the issue?

thanks,

greg k-h
