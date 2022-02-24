Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712A0C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 19:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbiBXTd7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 14:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbiBXTd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:33:57 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2A120428C;
        Thu, 24 Feb 2022 11:33:26 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D59865BF;
        Thu, 24 Feb 2022 19:33:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D59865BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1645731206; bh=pfteFMcBeSU5O1zvXhbYKaJIpax/VGepVWGGkWIcJj8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pSQo4UyXh85LHmLnYYovW36yjYdQ6CQVI+aq4jzYB8YRQKRXK570bUiE9x2ZeDQYk
         vpFZzHmi0aAAc+yR5ezJ+/lv/ZpR4QA9IZ3y8ZP5iAUICP/xo7MJ9FoPruGba94dnL
         DjcBGzbPSgzdWuNKj5wI7qsIgvasvCuc9OITPCPuOmJxQLQAQWkTLshDalBGpwmbi/
         fDlK7wGslhDyyVNcclbvWRazZB/LT5bB77vlIVlL/j1aB7hbo99aMzyuI9YHeZjz+x
         3jHYX2HflMOHi42VcTLxxYsk3KL5ZJWSTiLJCGxneh3EZt14SRrcjumVA4Eaa1o73+
         ZVHcxilE5g7Kg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH 1/3] docs: pdfdocs: Pull LaTeX preamble part out of conf.py
In-Reply-To: <aaa9dca1-27c0-c414-77f3-c5587db0cc5b@gmail.com>
References: <aaa9dca1-27c0-c414-77f3-c5587db0cc5b@gmail.com>
Date:   Thu, 24 Feb 2022 12:33:25 -0700
Message-ID: <875yp4kqka.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Yokosawa <akiyks@gmail.com> writes:

> Quote from Jon's remark [1]:
>
>     I do notice that Documentation/conf.py is getting large and
>     unapproachable.  At some future point, it might be nice to pull
>     all of the latex stuff out into a separate file where it won't
>     scare people who stumble into it by accident.
>
> Pull LaTeX preamble settings added since commit 3b4c963243b1 ("docs:
> conf.py: adjust the LaTeX document output") out into
> sphinx/kerneldoc-preamble.sty.
>
> It will be copied to the build directory by the added
> "latex_additional_files" setting in conf.py.
>
> As a bonus, LaTeX/TeX code can be maintained without escaping backslashes.

I've applied the set, thanks.  Still testing the pdfdocs build (and will
be for some time, naturally)

One little note, since you mentioned the need for backslash escapes:

> +# Load kerneldoc specific LaTeX settings
> +latex_elements['preamble'] += '''
> +        % Load kerneldoc specific LaTeX settings
> +	\\input{kerneldoc-preamble.sty}
> +'''

You can avoid that problem in Python code with the use of raw strings:

latex_elements['preamble'] += r'''
       % Load kerneldoc specific LaTeX settings
       \input{kerneldoc-preamble.sty}
'''

(note the "r" on the first line).  Something for future reference.

Thanks,

jon
