Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4005C4332F
	for <linux-kernel@archiver.kernel.org>; Tue, 31 May 2022 07:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244601AbiEaHmT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 May 2022 03:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244574AbiEaHmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 03:42:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F09F12D05
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 00:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653982934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DCmQQueLOwkbEgp46cmJprml7a8eekESmBiIv7Un50A=;
        b=R+4VdEQfpXZaspr7OS/5kmgd3k01bhb1rw9yLV/7/ZquCRyEjt4dscvD3p1vSA0gbjJNGY
        nu6ytbXCanuiXvaIgF+y7c4pbDVufvkasfDvMp0p8P8v1rfFgCT01h5uXFGXROfxv+S47t
        L1bPjVJD39zb2tKuLJQ/Ynx6fqT/l3Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-464-6c24Xha4PcWmzjofnbme1Q-1; Tue, 31 May 2022 03:42:13 -0400
X-MC-Unique: 6c24Xha4PcWmzjofnbme1Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9BA2429AB3F9;
        Tue, 31 May 2022 07:42:12 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 937EC40CFD0A;
        Tue, 31 May 2022 07:42:12 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 24V7gCGx015524;
        Tue, 31 May 2022 03:42:12 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 24V7gCMr015520;
        Tue, 31 May 2022 03:42:12 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 31 May 2022 03:42:12 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Borislav Petkov <bp@suse.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org
Subject: Re: Warnings when suspending to disk
In-Reply-To: <YpUcf19E+qgb6Eyu@kroah.com>
Message-ID: <alpine.LRH.2.02.2205310324410.13770@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2205301145540.25840@file01.intranet.prod.int.rdu2.redhat.com> <YpUcf19E+qgb6Eyu@kroah.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="185206533-923906028-1653982932=:13770"
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--185206533-923906028-1653982932=:13770
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT



On Mon, 30 May 2022, Greg Kroah-Hartman wrote:

> On Mon, May 30, 2022 at 12:16:24PM -0400, Mikulas Patocka wrote:
> > Hi
> > 
> > The commit 7f99cb5e60392fc3494c610776e733b68784280c ("x86/CPU/AMD: Use 
> > default_groups in kobj_type") causes the following warnings to be printed 
> > during suspend to disk and resume from disk. There are many of these 
> > warnings, 3 for each core.
> 
> And if you revert that change it goes back to not warning?
> 
> that is odd.

If I revert this change on 5.18, I end up with non-compilable kernel - it 
complains that ¡struct kobj_type¢ has no member named ¡default_attrs¢

However, I verified that the bug is present on commit 
7f99cb5e60392fc3494c610776e733b68784280c and absent on its parent commit 
26291c54e111ff6ba87a164d85d4a4e134b7315c.

> > 
> > The machine is two six-core Opterons 8435.
> > 
> > Mikulas
> > 
> > 
> > [   31.349584] PM: hibernation: hibernation entry
> > [   31.350319] Filesystems sync: 0.000 seconds
> > [   31.350417] Freezing user space processes ... (elapsed 0.001 seconds) done.
> > [   31.351994] OOM killer disabled.
> > [   31.357889] PM: hibernation: Preallocating image memory
> > [   34.791852] PM: hibernation: Allocated 735563 pages for snapshot
> > [   34.792065] PM: hibernation: Allocated 2942252 kbytes in 3.43 seconds (857.79 MB/s)
> > [   34.792296] Freezing remaining freezable tasks ... (elapsed 0.000 seconds) done.
> > [   34.793791] printk: Suspending console(s) (use no_console_suspend to debug)
> > [   34.795159] serial 00:03: disabled
> > [   34.795248] serial 00:02: disabled
> > [   34.824316] mptbase: ioc0: pci-suspend: pdev=0x00000000f4bc4e1a, slot=0000:02:06.0, Entering operating state [D3]
> > [   35.470390] amdgpu 0000:07:00.0: amdgpu: BACO reset
> > [   35.533783] Disabling non-boot CPUs ...
> > [   35.535798] smpboot: CPU 1 is now offline
> > [   35.537754] ------------[ cut here ]------------
> > [   35.537764] kernfs: can not remove 'threshold_limit', no directory
> 
> Before you suspend, is this directory (and the other ones) really there?

The files are present both before the suspend and after the 
suspend+resume. This is the list of files for one core:

/sys/devices/system/machinecheck/machinecheck0
/sys/devices/system/machinecheck/machinecheck0/bank0
/sys/devices/system/machinecheck/machinecheck0/bank1
/sys/devices/system/machinecheck/machinecheck0/bank2
/sys/devices/system/machinecheck/machinecheck0/bank3
/sys/devices/system/machinecheck/machinecheck0/bank4
/sys/devices/system/machinecheck/machinecheck0/bank5
/sys/devices/system/machinecheck/machinecheck0/cmci_disabled
/sys/devices/system/machinecheck/machinecheck0/dont_log_ce
/sys/devices/system/machinecheck/machinecheck0/check_interval
/sys/devices/system/machinecheck/machinecheck0/ignore_ce
/sys/devices/system/machinecheck/machinecheck0/monarch_timeout
/sys/devices/system/machinecheck/machinecheck0/northbridge
/sys/devices/system/machinecheck/machinecheck0/northbridge/dram
/sys/devices/system/machinecheck/machinecheck0/northbridge/dram/error_count
/sys/devices/system/machinecheck/machinecheck0/northbridge/dram/interrupt_enable
/sys/devices/system/machinecheck/machinecheck0/northbridge/dram/threshold_limit
/sys/devices/system/machinecheck/machinecheck0/northbridge/ht_links
/sys/devices/system/machinecheck/machinecheck0/northbridge/ht_links/error_count
/sys/devices/system/machinecheck/machinecheck0/northbridge/ht_links/interrupt_enable
/sys/devices/system/machinecheck/machinecheck0/northbridge/ht_links/threshold_limit
/sys/devices/system/machinecheck/machinecheck0/northbridge/l3_cache
/sys/devices/system/machinecheck/machinecheck0/northbridge/l3_cache/error_count
/sys/devices/system/machinecheck/machinecheck0/northbridge/l3_cache/interrupt_enable
/sys/devices/system/machinecheck/machinecheck0/northbridge/l3_cache/threshold_limit
/sys/devices/system/machinecheck/machinecheck0/power
/sys/devices/system/machinecheck/machinecheck0/power/autosuspend_delay_ms
/sys/devices/system/machinecheck/machinecheck0/power/control
/sys/devices/system/machinecheck/machinecheck0/power/runtime_active_time
/sys/devices/system/machinecheck/machinecheck0/power/runtime_status
/sys/devices/system/machinecheck/machinecheck0/power/runtime_suspended_time
/sys/devices/system/machinecheck/machinecheck0/print_all
/sys/devices/system/machinecheck/machinecheck0/subsystem
/sys/devices/system/machinecheck/machinecheck0/uevent

> Are they not getting created now properly somehow?  Any warning messages
> at boot time?

There are no warnings on boot.

> thanks,
> 
> greg k-h

Mikulas
--185206533-923906028-1653982932=:13770--

