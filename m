Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84154C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 06:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245727AbiF1GhG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 02:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343545AbiF1Ggp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 02:36:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A8F5FD1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 23:36:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 531E26193E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:36:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36482C3411D;
        Tue, 28 Jun 2022 06:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656398187;
        bh=6XoUp0iXdNcV2PCtIVIQaSjMJHqgxXdRjqglHkwSmDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oTVKGcId5JD8ODvdqM3K6/SeWZ2Qj88MO5Hlz+OzMswg0Ag/3q8WnF4mvi/ZZ85qu
         Hjmucy8Ge3HqbFMl3PoUpl9nSws7cMypqA6ACv05am+WPZXSzmOki+4JTkMej7dvDi
         StHDTdIJHWOMI4+J9Cl5nGJVOIpsB+PuA1AO4GOg=
Date:   Tue, 28 Jun 2022 08:36:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Dani Liberman <dliberman@habana.ai>
Subject: Re: [PATCH 11/12] habanalabs/gaudi2: add tpm attestation info uapi
Message-ID: <YrqhaBuzY/GkQXHx@kroah.com>
References: <20220627202620.961350-1-ogabbay@kernel.org>
 <20220627202620.961350-12-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627202620.961350-12-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 11:26:19PM +0300, Oded Gabbay wrote:
> From: Dani Liberman <dliberman@habana.ai>
> 
> User will provide a nonce via the ioctl, and will retrieve
> attestation data of the boot from the tpm, generated using given
> nonce.

Why not use the normal TPM api instead of a new/custom one?  Or is this
not a "normal" TPM device?  If not, you should say what it really is.

thanks,

greg k-h
