Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FB6C32793
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Aug 2022 07:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343618AbiHTHAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Aug 2022 03:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343574AbiHTHAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 03:00:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6852715FD3;
        Sat, 20 Aug 2022 00:00:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DF2C60EEF;
        Sat, 20 Aug 2022 07:00:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE04FC433C1;
        Sat, 20 Aug 2022 07:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660978840;
        bh=WqUeU0u9T96mpj7VyXSBk1dVwiSHTi7QZaXwlckRNFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sRWMpsaMj3v1lw7nuZlehQhNWmqpYzMrfr61q2aAVfiXd9vdh10Rm2Y5cZKztA3Qi
         kO1vu6QBcFsXdtGyNFKXFDPHlOUjSVnvT+SxQPBtGLZOiFxOpUILF7kyF87q9fNlQI
         nQiSC05NMzfg9ijuBUqfTU7lyn3dAvGQ2+y07OpE=
Date:   Sat, 20 Aug 2022 09:00:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     RAJESH DASARI <raajeshdasari@gmail.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org, df@google.com
Subject: Re: bpf selftest failed in 5.4.210 kernel
Message-ID: <YwCGoRt6ifOC6mCD@kroah.com>
References: <CAPXMrf-C5XEUfOJd3GCtgtHOkc8DxDGbLxE5=GFmr+Py0zKxJA@mail.gmail.com>
 <Yv3M8wqMkLwlaHxa@kroah.com>
 <Yv3wZLuPEL9B/h83@myrica>
 <Yv9shQ3i49efHG6f@kroah.com>
 <CAPXMrf8VsNMKNLxFjdytk57mk_9ZC0avg1qCGLSMOZNirpdboQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPXMrf8VsNMKNLxFjdytk57mk_9ZC0avg1qCGLSMOZNirpdboQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 07:20:11PM +0300, RAJESH DASARI wrote:
> Hi ,
> 
> I did some more tests ,  Please find the observation below.
> 
> step 1:  On v5.4.210 kernel , I reverted  only commit  bpf: Verifer,
> adjust_scalar_min_max_vals to always call update_reg_bounds()
> 7c1134c7da997523e2834dd516e2ddc51920699a , compiled the kernel and
> booted the system with the new kernel.
> step 2:  On system with newly compiled kernel , I clone the  v54.4.210
> source code  and  reverted  commit  selftests/bpf: Fix test_align
> verifier log patterns  and selftests/bpf: Fix "dubious pointer
> arithmetic" test , then ran the selftests, test_align test cases
> execution was successful.
> step 3: If i revert only selftests/bpf: Fix "dubious pointer
> arithmetic" test , test cases are still failing.
> 
> 
> 
> Please find the attached PDF for the other scenarios which I have executed.

For obvious reasons, we can't read random .pdf files sent to us.  Please
put it all in text.

thanks,

greg k-h
