Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDABC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 10:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345689AbiCHKRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 05:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345627AbiCHKRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:17:11 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51563FD8F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 02:16:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1CE37CE1389
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 10:16:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E77C340EF;
        Tue,  8 Mar 2022 10:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646734572;
        bh=5PRdAeQUtYXT169fiOt10pRLXqanDooFjKN+Av0OCjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nMFSz7CvbWIgO2EzvfUgjkOB1DpMcOjLHZPuDNX5/QXn7JtcvT0SexZlCaCg2dzFy
         K2kN9C5SrHcNqL78WoH+QoHgI2A3s1ILqAw1C3MMcePt6bOh2Skm4xU+t5GgFAR4Qb
         YQooCHq+CycXItE1OpMEJm/X5301ZCyP5wztWTdY=
Date:   Tue, 8 Mar 2022 11:16:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     butt3rflyh4ck <butterflyhuangxx@gmail.com>
Cc:     fei1.li@intel.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virt: acrn: fix a memory leak in acrn_dev_ioctl()
Message-ID: <Yics6JbQljlQXRED@kroah.com>
References: <20220308092047.1008409-1-butterflyhuangxx@gmail.com>
 <YicoOC+WZhNLq+pX@kroah.com>
 <CAFcO6XMy+rT_cnw2Q7Jzg=byKWQ8tcVU+8ZBCCfTD1-JNy7oLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFcO6XMy+rT_cnw2Q7Jzg=byKWQ8tcVU+8ZBCCfTD1-JNy7oLw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 06:14:31PM +0800, butt3rflyh4ck wrote:
> No, not yet. I just code audit.

Please test things like this so that we know it actually is correct.

thanks,

greg k-h
