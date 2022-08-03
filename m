Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AF4C19F28
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Aug 2022 06:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbiHCGRt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Aug 2022 02:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236877AbiHCGRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:17:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A671933E12
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 23:17:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 433A7614AE
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 06:17:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F816C4314D;
        Wed,  3 Aug 2022 06:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659507464;
        bh=Sa1PJCAxuecX6p+YKlYX+PAcaTOoK5G7arRKR6NK8xk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rAnhxuLoZLt63gvwPfbRA0j3GS+jM44VaWa1xFVmHhUVVrVIZUVs/krJOBj+4+roW
         NgGgLQo7SfA/UV2nrnuLhLtSjuJva7r8MY129DoHw6KO1pMZd7eSJvPQ60CY1gjFar
         IF2Qj0hpxCXhitX9IS2xXDcuzv8v/teXo7CS3YkA=
Date:   Wed, 3 Aug 2022 08:17:42 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Winiarska, Iwona" <iwona.winiarska@intel.com>
Cc:     "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] PECI changes for v6.0-rc1
Message-ID: <YuoTBoxohRuS05ea@kroah.com>
References: <e34c084a69cc5c51c60b1813ac7fdf0b845d1226.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e34c084a69cc5c51c60b1813ac7fdf0b845d1226.camel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 12:18:24AM +0000, Winiarska, Iwona wrote:
> Hi Greg,
> 
> please pull PECI update for Linux v6.0-rc1.

Sorry but as you know, it's too late for changes to my tree.  This will
have to wait until after 5.20-rc1 (or 6.0-rc1) is out and then I'll be
glad to take them.

thanks,

greg k-h
