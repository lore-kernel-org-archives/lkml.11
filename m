Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B69C25B0D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Aug 2022 04:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiHPE3Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Aug 2022 00:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiHPE3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 00:29:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14434BD10D;
        Mon, 15 Aug 2022 18:09:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBB4EB8124C;
        Tue, 16 Aug 2022 01:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36ADC433C1;
        Tue, 16 Aug 2022 01:09:23 +0000 (UTC)
Date:   Mon, 15 Aug 2022 21:09:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.19 0000/1157] 5.19.2-rc1 review
Message-ID: <YvruPKI4dCyrXCp5@home.goodmis.org>
References: <20220815180439.416659447@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815180439.416659447@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 07:49:16PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.19.2 release.
> There are 1157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Hi Greg,

Perhaps its time that you just send a single email to LKML pointing where to
find the stable releases. These patch bombs are bringing vger down to its
knees, and causing delays in people's workflows. This doesn't just affect
LKML, but all other vger mailing lists. Probably because LKML has the biggest
subscriber base that patch bombs to it can slow everything else down.

I sent 3 patches to the linux-trace-devel list almost 4 hours ago, and they
still haven't shown up. I was going to point people to it tonight but it's now
going to have to wait till tomorrow.

I really do not think LKML needs to see all 1157 patches that are being
backported. There's other places to send them that will not be as disruptive.

Thanks,

-- Steve

