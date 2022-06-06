Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C042DC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jun 2022 05:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiFFFy6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jun 2022 01:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiFFFyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 01:54:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AB031230
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 22:54:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C328D60E9E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 05:54:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29D3C385A9;
        Mon,  6 Jun 2022 05:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654494887;
        bh=y5zL+ZQSVXvlA8S/GFXMIDb6PD6Pb5fiMny8Nd9GrJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gnnvbi3JDZhS19D+BR//B63gt0JNvIiGmCwDj+0X4D6iqsajiVU7btW/en0sCQG1/
         39Br/XIqj2VuoFG4OxlR4qnuHTevfVppvgh8O3uye3fmzzsquUUSv2eqs94bsZcLjs
         Rbp0QQD97bSs54qxSjA7xuJFqxg/21KrNHB/I94Y=
Date:   Mon, 6 Jun 2022 07:54:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     nsaenz@kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] staging: vchiq: make vchiq_platform_init static
Message-ID: <Yp2WpCKVjLMe0qJO@kroah.com>
References: <20220525093851.59514-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220525093851.59514-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 05:38:51PM +0800, Jiapeng Chong wrote:
> This symbol is not used outside of vchiq_arm.c, so marks it
> static.
> 
> Fixes the following w1 warning:

What tool is "w1"?

> 
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:466:5:
> warning: no previous prototype for ‘vchiq_platform_init’
> [-Wmissing-prototypes].

See my previous comments on how to do this properly.

thanks,

greg k-h
