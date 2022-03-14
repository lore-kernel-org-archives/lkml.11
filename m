Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999CFC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 08:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237459AbiCNI5e (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 04:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234859AbiCNI5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 04:57:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E046F32048;
        Mon, 14 Mar 2022 01:56:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DE92B80D24;
        Mon, 14 Mar 2022 08:56:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1ABC340EC;
        Mon, 14 Mar 2022 08:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647248177;
        bh=L8Yk7srM64uKjMYzcLighf4ztuXuhHCrxD4dKl1b7WI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ky7wmaQMO01enox9g+dzRE1/OVuQLSfwzQqcCL2FRgOfAOYsRwiE2ps1/WadcQgll
         yGqU+gM9deRXNOm3osSeOiwgf9S3wDG+L/GGU8XZB12/8vtV1Blr7nOP+lZarIs1y/
         3IC2vmqVqxqzhC+qXZ8a3kfccKBlO7cm79VMnHz4=
Date:   Mon, 14 Mar 2022 09:56:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     mst@redhat.com, jasowang@redhat.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <Yi8DLVFyczFreWn7@kroah.com>
References: <20220314084302.2933167-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314084302.2933167-1-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 08:43:02AM +0000, Lee Jones wrote:
> vhost_vsock_handle_tx_kick() already holds the mutex during its call
> to vhost_get_vq_desc().  All we have to do here is take the same lock
> during virtqueue clean-up and we mitigate the reported issues.
> 
> Also WARN() as a precautionary measure.  The purpose of this is to
> capture possible future race conditions which may pop up over time.

These two sentances do not match your actual patch :(

> Cc: <stable@vger.kernel.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

What commit caused this problem?  Can you add a Fixes: line as well for
this?

thanks,

greg k-h
