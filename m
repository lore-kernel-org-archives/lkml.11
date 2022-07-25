Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798C4CCA48A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jul 2022 18:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbiGYSF7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jul 2022 14:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbiGYSF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 14:05:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECEF5F6C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 11:05:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C04761376
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 18:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11783C341C6;
        Mon, 25 Jul 2022 18:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658772356;
        bh=A+xNeGPneLFwkZxPMiltoykKB8Es4RbWRTW+xpD7pVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jlJJMIgjjkT4+NarOvwTnNNRxOyDcFdb4kO+7jQ1EU6MqnYhOOxhoFxW6H72A4VvP
         O+zG3ga7tQNVjcMCpGp1Z5+8sn9CxTZNShymf3uOkn5eUmBQyLuOrj/6x1DpJEIdoZ
         DsEoKMvlnQdStbJK44qO2Vt7OCiCVOAI4X8WphMc=
Date:   Mon, 25 Jul 2022 20:05:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     vdasa@vmware.com
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, pv-drivers@vmware.com,
        bryantan@vmware.com
Subject: Re: [PATCH] VMCI: Update maintainers for VMCI
Message-ID: <Yt7bfyANrfdPxdS8@kroah.com>
References: <20220725163246.38486-1-vdasa@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725163246.38486-1-vdasa@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 09:32:46AM -0700, vdasa@vmware.com wrote:
> From: Vishnu Dasa <vdasa@vmware.com>
> 
> Remove Rajesh as a maintainer for the VMCI driver.

Why?

> 
> Acked-by: Bryan Tan <bryantan@vmware.com>
> Signed-off-by: Vishnu Dasa <vdasa@vmware.com>

I need an ack from the person that is being removed here, for obvious
reasons.  Any specific reason you didn't cc: them on this patch?

thanks,

greg k-h
