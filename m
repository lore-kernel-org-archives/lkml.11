Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07CAC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 15:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348323AbiC3Pj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 11:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348276AbiC3PjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:39:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBED5BE73
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:37:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F01CD616F5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 15:37:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01EE2C340EE;
        Wed, 30 Mar 2022 15:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648654657;
        bh=RvGSrHfLJfpTbs3Ho41Zt/SklOEmkN76AbpAlx2jjQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JNHPNkCK84WCxlQWy1aWbD86y++YAuEhpkE1Kwi/lOAGKFchd2S7CQ8saRjgdh8AB
         x2Ygsqu51iPrAOa2kWb9eM0hqmlGtOBKNJDv2ImlDuKYBx449Z0xWetqUjkcaC60VE
         ygoOpuE3HiiaOGUjoeQlU02XEJx2maY1rSAF1p6o=
Date:   Wed, 30 Mar 2022 17:37:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5ZC05L+K5paH?= <wudaemon@163.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v2] char: misc:use DEFINE_PROC_SHOW_ATTRIBUTE micro
 to simplify misc proc_fops
Message-ID: <YkR5PkJq27NIdY52@kroah.com>
References: <20220327143254.226844-1-wudaemon@163.com>
 <YkFM2Ko21j8Ehca8@kroah.com>
 <4ac4969e.8288.17fdb6206ea.Coremail.wudaemon@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ac4969e.8288.17fdb6206ea.Coremail.wudaemon@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 11:11:48PM +0800, 吴俊文 wrote:
> Dear Greg:
> It means I should list  the reason  why I ptach a new verson?like this:

I do not know what you are referring to, sorry.  Also, html email is
rejected by the mailing list and out tools, please fix.

thanks,

greg k-h
