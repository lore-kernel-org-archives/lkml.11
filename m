Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB93C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 21:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiCHVfa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 16:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241473AbiCHVf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 16:35:27 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC22A54FAB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 13:34:28 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B7AF3FF804;
        Tue,  8 Mar 2022 21:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646775267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DbGDTAkv+8jp52xleEc1lU2kXFn/CtcrBMvCJ5j8Z9A=;
        b=AV8Q7yXdq8imGC10NijVlFZ9zgrOPUHBKdoCCyopNuNWP80zyQsQIce6+XQMUjMjGZONdi
        66eFsyOxn9XDbF1nLC9aekuktnUSDTHxO53z82NeFx0hp/rAlFZpiCh9fmS1ykWxsOlrHw
        N6lZ3u+Xz8XKEkRmfTb7zQzEHm7WK2B649huyVM8dJYbsMZOqrvfjte401/zlG9Abkq8ky
        H8dFJxRCWZkTRu2VXCi9JrYC8oLhpX+q658uPFGmnuG+L1BT+XVMG6xNZ6Shh4odikoMq4
        UkDbNeLrdb0v3VdRhVtTGFAOKKHzKXvaoc/n/FNHZY07GYxZM7k0ASSwxPzeWQ==
Date:   Tue, 8 Mar 2022 22:34:26 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the i3c tree
Message-ID: <YifL4q/R3VBho8/6@piout.net>
References: <20220309082720.0f32c2f9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309082720.0f32c2f9@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2022 08:27:20+1100, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   6f5bad3d6960 ("i3c: fix uninitialized variable use in i2c setup")
> 
> Fixes tag
> 
>   Fixes: 97a82882d852 ("i3c: remove i2c board info from i2c_dev_desc")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Maybe you meant
> 
> Fixes: 31b9887c7258 ("i3c: remove i2c board info from i2c_dev_desc")

Thanks, fixed!

> 
> -- 
> Cheers,
> Stephen Rothwell



-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
