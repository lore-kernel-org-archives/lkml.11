Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E35BC43334
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jun 2022 10:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238850AbiFTK0S (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jun 2022 06:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239908AbiFTK0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:26:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4A113E8B;
        Mon, 20 Jun 2022 03:26:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 178F160B28;
        Mon, 20 Jun 2022 10:26:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E754DC3411B;
        Mon, 20 Jun 2022 10:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655720763;
        bh=Wal+H1rMTMUMX67N1hK9qOOenXwy00Js2GP0OU5lLmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nLD/STKXRr4oGH09HyHcudKrcxGfa2TnFtj0fGs+YchvfpQ/yHENjP/tlZc0XSBcp
         a3JfWGHDkUt4EwoQd8oaukI/RVZq4dBRo4E2obYlxv3X4k0juV6YtlUIB2Ou/jgdEE
         ZO/ExEnaVlHTsyeSHYOLsfyVm1dTWcmbORoXqA+U=
Date:   Mon, 20 Jun 2022 12:26:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Cc:     andy.shevchenko@gmail.com, arnd@arndb.de, corbet@lwn.net,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com,
        guy.zadicario@intel.com, linus.walleij@linaro.org, olof@lixom.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 00/14] Driver of Intel(R) Gaussian & Neural Accelerator
Message-ID: <YrBLOPHGAZgFJvWN@kroah.com>
References: <85a6nq45uh.fsf@linux.intel.com>
 <20220620094907.4101274-1-maciej.kwapulinski@linux.intel.com>
 <YrBEP4P9JA60LeOB@kroah.com>
 <86czf3wsrg.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86czf3wsrg.fsf@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 12:08:34PM +0200, Maciej Kwapulinski wrote:
> 
> Greg KH <gregkh@linuxfoundation.org> writes:
> 
> > On Mon, Jun 20, 2022 at 11:49:07AM +0200, maciej.kwapulinski@linux.intel.com wrote:
> >> Please share your thoughts.
> >
> > No code here to share thoughts about :(
> 
> code will be published in comming weeks to dri-devel ML

Saying "we will send patches sometime in the future" is a bit odd when
we have thousands of patches each week in our inbox to review now.  Why
not help us out with that workload?  :)

thanks,

greg k-h
