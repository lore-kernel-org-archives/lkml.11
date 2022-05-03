Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9EEC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 May 2022 14:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbiECO32 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 May 2022 10:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236992AbiECO3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 10:29:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB62331226;
        Tue,  3 May 2022 07:25:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BEC9B81EF4;
        Tue,  3 May 2022 14:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2A2C385A9;
        Tue,  3 May 2022 14:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651587946;
        bh=bjajBN4dW/sBvAcyhS50R74qtpo2wFyJEHVvy9Fh4eM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pF5LqxnmAEuQujDJiQyG6OPv8E/EgKRS/VrnbJ0RRrjuL7pPPOZSdm5C9D5D1g5hX
         4A42+s3XANafPztRPOiocIAH2dKbynvv+KFvSx8U+Aaf9eT0FYMUcjYWxuzPtoktJI
         5EKY5Iytd7/9Oyk6wPBMwTvTngtrfb+Uvx9u6eW8=
Date:   Tue, 3 May 2022 16:25:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 4.19 00/12] 4.19.241-rc1 review
Message-ID: <YnE7aX7p4iQvOrZf@kroah.com>
References: <20220429104048.459089941@linuxfoundation.org>
 <20220503141652.GA3698419@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503141652.GA3698419@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 07:16:52AM -0700, Guenter Roeck wrote:
> On Fri, Apr 29, 2022 at 12:41:17PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.241 release.
> > There are 12 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun, 01 May 2022 10:40:41 +0000.
> > Anything received after that time might be too late.
> > 
> 
> No cc this time ?

You and Pavel said this, yet I see your response here:
	https://lore.kernel.org/r/20220429234822.GB2444503@roeck-us.net
that you sent on Friday.

Did some old email get unstuck and resent somehow?

4.19.241 was released on Sunday, I have not sent out new -rc
announcements yet.

confused,

gre gk-h
