Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E72C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 07:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbiF0HYK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 03:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiF0HYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:24:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25CF5F9E;
        Mon, 27 Jun 2022 00:24:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61D7061353;
        Mon, 27 Jun 2022 07:24:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00952C341C8;
        Mon, 27 Jun 2022 07:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656314642;
        bh=hiXi3UrYgUhaJWeEi82xz9OOw9JFYZDtX3kek1cydn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nlXxUAiA8ITEDbLnALbs3k30MYcEgSYiM10FExaxFukCu2xFR2i6lehP4WzbUHjHW
         fKSqC0EPrx2iFkfV9KI/ALQU5OIc7nt4DGQpanTfiYl76kZUOA+VjCcLUCWAJRkt76
         Zzj9yMGO7FZKgsfd1VK9Eg9/2Y+aCEvIS7JOR2X0=
Date:   Mon, 27 Jun 2022 09:23:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     RAJESH DASARI <raajeshdasari@gmail.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Reg: rseq selftests failed on 5.4.199
Message-ID: <YrlbDgpIVFvh5L9O@kroah.com>
References: <CAPXMrf-_RGYBJNu51rq2mdzcpf7Sk_z3kRNL9pmLvf4xmUkmow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPXMrf-_RGYBJNu51rq2mdzcpf7Sk_z3kRNL9pmLvf4xmUkmow@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2022 at 10:01:20PM +0300, RAJESH DASARI wrote:
> Hi ,
> 
> We are running rseq selftests on 5.4.199 kernel with  glibc 2.34
> version  and we see that tests are failing to compile with invalid
> argument errors. When we took all the commits from
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/tools/testing/selftests/rseq
>  related to rseq locally , test cases have passed. I see that there are
> some adaptations to the latest glibc version done in those commits, is
> there any plan to backport them to 5.4.x versions. Could you please
> provide your inputs.

What commits specifically are you referring to please?  A list of them
would be great, and if you have tested them and verified that they can
be backported cleanly would also be very helpful.

thanks,

greg k-h
