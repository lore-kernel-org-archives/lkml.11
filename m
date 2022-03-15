Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73232C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 06:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345284AbiCOGub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 02:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbiCOGu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 02:50:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D0A26100
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 23:49:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9D42612DC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:49:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA908C340EE;
        Tue, 15 Mar 2022 06:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647326953;
        bh=Ps6QwQcrZ+HhsjG/Mc4TDw0HHEPxpKdhpSA0IXDtV/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xrrQHEHAAJEu23YkN6X6tgDw5G10skC2YVU+gLpR4csLETB3fRkSUV3Hygtv3pY/j
         Jfa46bBWl1S9AahLeIZnuG+9wTYFvNhSBgFnMtFr/g/vJKiXtyiTXaLeNQZwUoEjEy
         ZH/Z62wBZe+iKLgJPouzFsvJ5e1mqXDRMOoLtGEY=
Date:   Tue, 15 Mar 2022 07:49:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     butt3rflyh4ck <butterflyhuangxx@gmail.com>
Cc:     Li Fei1 <fei1.li@intel.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virt: acrn: fix a memory leak in acrn_dev_ioctl()
Message-ID: <YjA24K4FVZU6fTMd@kroah.com>
References: <20220308092047.1008409-1-butterflyhuangxx@gmail.com>
 <YicoOC+WZhNLq+pX@kroah.com>
 <CAFcO6XMy+rT_cnw2Q7Jzg=byKWQ8tcVU+8ZBCCfTD1-JNy7oLw@mail.gmail.com>
 <Yics6JbQljlQXRED@kroah.com>
 <CAFcO6XNLfOTp2M3B876YTt+atNTveuqH7Q3ePk3N-T=KkJkiTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFcO6XNLfOTp2M3B876YTt+atNTveuqH7Q3ePk3N-T=KkJkiTQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 10:44:09AM +0800, butt3rflyh4ck wrote:
> Hi, Greg, could you tell me how to test (like this)?

I have no context at all what "like this" is sorry.

greg k-h
