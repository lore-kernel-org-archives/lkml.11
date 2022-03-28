Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7284C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Mar 2022 08:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239061AbiC1ICb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Mar 2022 04:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiC1ICa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 04:02:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A6E52E58;
        Mon, 28 Mar 2022 01:00:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7CEBDB80ED0;
        Mon, 28 Mar 2022 08:00:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C64C004DD;
        Mon, 28 Mar 2022 08:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648454447;
        bh=DVVPBkIqd00aJ3fKq0pOht4NcHuPAqm7DnElPPhiDR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V+xEX9U7JsvN2YPpa0sKfu6lg13w5K/rcJ1t8781dOcIhNHLzL36Wczf7Jvw6q3gq
         eKx9O1GpY3G5AcSnQITFxd1yayuVHHUOnXPhEEWKI2+ewh6usnxpSDrUO1UC4s6ctX
         BMFCelBJfz8UEtw1VzXysilRLVzbeGy6s1GOiyNU=
Date:   Mon, 28 Mar 2022 10:00:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Luna Jernberg <droidbittin@gmail.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.16 00/37] 5.16.18-rc1 review
Message-ID: <YkFrLJKM/e4Qw8E6@kroah.com>
References: <20220325150420.046488912@linuxfoundation.org>
 <CA+G9fYuNg3=ig3A5J0oOojC4ywtf_yUeyMoPwYrFBGvzeexWZA@mail.gmail.com>
 <CADo9pHjy2k56yyesE_Y9N6S1cMJwH2GP912X1=v5nzohfSjaTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADo9pHjy2k56yyesE_Y9N6S1cMJwH2GP912X1=v5nzohfSjaTA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2022 at 11:39:35AM +0100, Luna Jernberg wrote:
> Works on my i7 4790k with EndeavourOS
> 
> 
> Tested-by: Luna Jernberg <droidbittin@gmail.com>

Please do not send html email to the lists, nor top post.

thanks for testing!

greg k-h
