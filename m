Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A4AC433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Mar 2022 09:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiCLJnz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Mar 2022 04:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbiCLJnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 04:43:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71302CEC;
        Sat, 12 Mar 2022 01:42:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26DDEB82E1B;
        Sat, 12 Mar 2022 09:42:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC60C340EB;
        Sat, 12 Mar 2022 09:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647078164;
        bh=V5CM8pcgwHLVgx8839TONa+k6ERr6kXSI2RcIM87I6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SjlYmy5PQCh2FMS/olDBvR1TUSPUYqHfDfoaSpXJ6oha3iGrYZ2AQb4nWFG4oZg6n
         /0P3R+LdUJATGBO/zc/yOGG3uCKARG4m2VNDoR4AxTKnDetKeSXHwNr8e0jpQACFqT
         jXJSQ2N3uw+4wxhD26B0Oo3QHMAHIgpgKqF7kjmU=
Date:   Sat, 12 Mar 2022 10:42:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-doc@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] Documentation: make option lists subsection of
 "Procedure for submitting patches to the -stable tree" in
 stable-kernel-rules.rst
Message-ID: <YixrEFMkSZthmQpo@kroah.com>
References: <20220312080043.37581-1-bagasdotme@gmail.com>
 <20220312080043.37581-2-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220312080043.37581-2-bagasdotme@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2022 at 03:00:40PM +0700, Bagas Sanjaya wrote:
> The table of contents generated for stable-kernel-rules.rst contains
> "For all other submissions..." section, that includes options
> subsections. These options subsections should have been subsections of
> "Procedure for submitting patches..." section. Remove the redundant
> section.

The subject line is really long, was that intentional?

> 
> Also, convert note about security patches to use `.. note::` block.

When you have an "also" that's a huge hint it should be a separate
commit.

thanks,

greg k-h
