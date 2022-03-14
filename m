Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B9AC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 18:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237644AbiCNSZy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 14:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbiCNSZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 14:25:53 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7513B563
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 11:24:42 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 1so12927645qke.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 11:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WzM8onKgtpRf9pu36Rc/MnvN6d5RHE8+6dA8lDFE29o=;
        b=UkknauDkLxctXMKPfBYReK5fLkpsRQnTb/lLakkCtayo91pyMtn/BQP92ntSIFnPJL
         zZZ3EEoKVq800PEDwB+SNhsgFc7/fLsIsldKGOW8v1tkZei8HSoUWNUm348c5ErUPRyk
         XXn5Eb2+ncqb4rwQfBk23KTBvyC3qaCGw13o8az+b8K9ZMLUcuzsNVbiOulwbvlO9HgW
         zg5C6iH5wzaN/MMVKhtkCCRr4ts7pSNjNSjKiLJofV4Q6hIQN1JraRLrJzszh7vwKsvD
         Ev2KlofLSfMNLLq6369iiMEH9/z8ztLK33lIVrdbG41ii9uQvpDBqtbLWoAF5dYb3svD
         o/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WzM8onKgtpRf9pu36Rc/MnvN6d5RHE8+6dA8lDFE29o=;
        b=JJ7VRb4z/skedt5rAdcEbZJ5Brcic8IjZG4Pb9KtzrO4vgFkogz4PkD8vwyIlPu4Qw
         5o5yfHNB6bU3+3AcWHnq+6TfBXleexOLTnjkVppKGbQQ5iRjJFzr6GcKJoiGfH6sJzc8
         LA6lF+4wtXRW4xHYmMYyvVkdjjvIxU19skpTg0SkXpT06hI+90UzkR1A6188C9OZ6dYL
         By9+tPDGbo0PfZPlRX5tjC9euwoDN5JhDQXVkpVx5f9X4guIgTfoiFvHHIt9+tAk40ok
         9AqqsnoqyBzOsAA8myT4iQ81/o1kMxF2/aVMLUKj6yR+Z39jXnuwJSlIFDUWuDWhqzjm
         qvxA==
X-Gm-Message-State: AOAM5325piCvilsZRfVp7WcW1o/OsT38Ie6tPBVKLCpxCHm8GOpnfnmU
        KX80HOzOAhXLpDNZxH4ZTJKX3Q==
X-Google-Smtp-Source: ABdhPJza7gdcTvDezy7LqMZeXnQjGtoym/j9bUPXKCDR3cRCg6RvO9AQ1sVjjcpITrhsob4oZktxkA==
X-Received: by 2002:a05:620a:13f2:b0:60b:d595:6db1 with SMTP id h18-20020a05620a13f200b0060bd5956db1mr16006671qkl.366.1647282281351;
        Mon, 14 Mar 2022 11:24:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id t207-20020a3746d8000000b0067b33b6a4efsm8111557qka.21.2022.03.14.11.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 11:24:40 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nTpN1-000RjZ-Hw; Mon, 14 Mar 2022 15:24:39 -0300
Date:   Mon, 14 Mar 2022 15:24:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     mpenttil@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        apopple@nvidia.com, jhubbard@nvidia.com, rcampbell@nvidia.com,
        vbabka@suse.cz
Subject: Re: [PATCH v2] mm/hmm/test: simplify hmm test code: use miscdevice
 instead of char dev
Message-ID: <20220314182439.GB64706@ziepe.ca>
References: <20220311033050.22724-1-mpenttil@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220311033050.22724-1-mpenttil@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 05:30:50AM +0200, mpenttil@redhat.com wrote:
> From: Mika Penttilä <mpenttil@redhat.com>
> 
> HMM selftests use an in-kernel pseudo device to emulate device private
> memory. The pseudo device registers a major device range for two pseudo
> device instances. User space has a script that reads /proc/devices in
> order to find the assigned major number, and sends that to mknod(1),
> once for each node.
> 
> This duplicates a fair amount of boilerplate that misc device can do
> instead.
> 
> Change this to use misc device, which makes the device node names appear
> for us. This also enables udev-like processing if desired.

This is borderline the wrong way to use misc devices, they should
never be embedded into other structs like this. It works out here
because they are eventually only placed in a static array, but still
it is a generally bad pattern to see.

> Delete the /proc/devices parsing from the user-space test script, now
> that it is unnecessary.

This is all because the cdev is being used wrong - it get all this
stuff it should be done via cdev_device_add() and a dmirror_device
needs a struct device to hold the sysfs.

Jason
