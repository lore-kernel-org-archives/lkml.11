Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA87C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 21:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245587AbiCJVnB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 16:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244741AbiCJVmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 16:42:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8B016FDE9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 13:41:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12864B825F2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACE1C340E8;
        Thu, 10 Mar 2022 21:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646948510;
        bh=IHIGH8VQeIMqkTxrdZMNBNPGNyfnXTljpt3MpP9xA5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eUQjxW48yvusyqGAU8fHLbgiAfv6qGsUdPtgJr5bhzAIyn78qAjpEhaOYIHbYKRko
         O1eHG0dwBpdeZ3oDfHM6Yh5wa3nAAU/DnkET0H/eSu+W358jCcEoC6HdBEQ3v6hsZt
         K3s11e/4UIoYzR3SVIE4Sxrj3wwhz42fLhnLdE4A=
Date:   Thu, 10 Mar 2022 22:40:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs pull request for kernel 5.18
Message-ID: <YipwTAfBdZpuLYQA@kroah.com>
References: <20220228135111.GA1174849@ogabbay-vm-u20.habana-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228135111.GA1174849@ogabbay-vm-u20.habana-labs.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 03:51:11PM +0200, Oded Gabbay wrote:
> Hi Greg,
> 
> This is habanalabs pull request for the merge window of kernel 5.18.
> Although it adds small number of features, this pull request mainly
> fixes multiple bugs in the code and also does some re-factoring to
> better organize the code.
> 
> Full details are in the tag.
> 
> Thanks,
> Oded
> 
> The following changes since commit 085686fb8491a7cbf6a7260d5b9d4169a041c340:
> 
>   Merge 5.17-rc6 into char-misc-next (2022-02-28 07:30:32 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-next-2022-02-28
> 
> for you to fetch changes up to 655221c56739058ae73a7aabd90847a024dabff6:
> 
>   habanalabs: remove deprecated firmware states (2022-02-28 14:34:50 +0200)

Pulled and pushed out, thanks.

greg k-h
