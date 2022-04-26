Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB142C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Apr 2022 21:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355254AbiDZVLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Apr 2022 17:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243506AbiDZVLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:11:14 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE4A6D4F5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651007285; x=1682543285;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L2aiClk+1ighNnSdgTpBPizL0Y+boQZg3WeLjQ9uEkk=;
  b=oiAiXptJfcklIKNWjdxKeSttUNybZSHHpTfs87Q61/zIYIQo90lj/GFX
   DNex1lzSVp9zDsXUNOKFgaEgFJq+Xv+ghI/bZ5JZXiRFhilUUWMSrdNGy
   Ybvhyb8udWKeoXwqIt0WN1wM6VFw/qpTKjlW7OD54gsMHAumdxIHdyqpE
   0=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 26 Apr 2022 14:08:05 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 14:08:05 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 26 Apr 2022 14:08:04 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 26 Apr
 2022 14:08:03 -0700
Date:   Tue, 26 Apr 2022 17:08:01 -0400
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Zi Yan <ziy@nvidia.com>
CC:     David Hildenbrand <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Oscar Salvador" <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v11 0/6] Use pageblock_order for cma and
 alloc_contig_range alignment.
Message-ID: <20220426210801.GA1038@qian>
References: <20220425143118.2850746-1-zi.yan@sent.com>
 <20220426201855.GA1014@qian>
 <B621B4DD-5D11-4F0E-AFF5-F8684AE37E57@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <B621B4DD-5D11-4F0E-AFF5-F8684AE37E57@nvidia.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 04:26:08PM -0400, Zi Yan wrote:
> Thanks for reporting the issue. Do you have a reproducer I can use to debug the code?

Nothing fancy. It just try to remove and add back each memory section.

#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0

import os
import re
import subprocess


def mem_iter():
    base_dir = '/sys/devices/system/memory/'
    for curr_dir in os.listdir(base_dir):
        if re.match(r'memory\d+', curr_dir):
            yield base_dir + curr_dir


if __name__ == '__main__':
    print('- Try to remove each memory section and then add it back.')
    for mem_dir in mem_iter():
        status = f'{mem_dir}/online'
        if open(status).read().rstrip() == '1':
            # This could expectedly fail due to many reasons.
            section = os.path.basename(mem_dir)
            print(f'- Try to remove {section}.')
            proc = subprocess.run([f'echo 0 | sudo tee {status}'], shell=True)
            if proc.returncode == 0:
                print(f'- Try to add {section}.')
                subprocess.check_call([f'echo 1 | sudo tee {status}'], shell=True)

